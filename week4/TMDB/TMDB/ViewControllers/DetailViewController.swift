//
//  DetailViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/16.
//

import UIKit
import Kingfisher

enum ContentInfo: CaseIterable {
    case overview
    case cast
    case crew
    
    var text: String {
        switch self {
        case .overview: return "OverView"
        case .cast: return "Cast"
        case .crew: return "Crew"
        }
    }
}

class DetailViewController: UIViewController {

    @IBOutlet var movieInfoTableView: UITableView!
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    var content: Trend?
    
    var cast: [Cast] = []
    var crew: [Cast] = []
    
    var isDetailed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        configureView()
        
        guard let content = self.content else { return }
        
        TmdbAPIManager.shared.fetchCredit(movieID: content.id) { credit in
            self.cast = credit.cast
            self.crew = credit.crew
        }
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 10
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else { return UITableViewCell() }
            
            if let content = self.content {
                cell.configureCell(overview: content.overview)
            }
            
            cell.delegate = self
            cell.indexPath = indexPath
            
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContentInfo.allCases[section].text
    }
    
}

extension DetailViewController: moreOverviewButtonTappedDelegate {

    func buttonTapped(index: IndexPath) {
        movieInfoTableView.reloadRows(at: [index], with: .none)
    }

}

extension DetailViewController {
    
    func configureView() {
        configureNavigationBar()
        configureTableView()
        
        setData()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func configureTableView() {
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self
        
        movieInfoTableView.rowHeight = UITableView.automaticDimension
//        movieInfoTableView.estimatedRowHeight = 130
        
        let overviewCellNib = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        movieInfoTableView.register(overviewCellNib, forCellReuseIdentifier: OverviewTableViewCell.identifier)
    }
    
    func configureTableViewHeader() {
        backdropImageView.contentMode = .scaleToFill
    }
    
    func setData() {
        guard let content = self.content else { return }
        
        let backdrop = URL(string: URL.imageURL + content.backdropPath)
        backdropImageView.kf.setImage(with: backdrop)
        
        titleLabel.text = content.title != nil ? content.title : content.name
        
        let poster = URL(string: URL.imageURL + content.posterPath)
        posterImageView.kf.setImage(with: poster)
    }
    
}
