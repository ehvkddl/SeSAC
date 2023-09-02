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
    case season
    
    var text: String {
        switch self {
        case .overview: return "OverView"
        case .cast: return "Cast"
        case .crew: return "Crew"
        case .season: return "Season"
        }
    }
}

class DetailViewController: UIViewController {

    @IBOutlet var movieInfoTableView: UITableView!
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    var type: MediaType?
    var id: Int?
    var content: VideoInfo?
    
    var detail: TvDetails?
    
    var cast: [Cast] = []
    var crew: [Cast] = []
    
    var isExpand: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "출연/제작"
        
        configureView()
        
        guard let type = self.type else { return }
        guard let id = self.id else { return }
        
        TmdbAPIManager.shared.fetchCredit(type: type, id: id) { credit in
            self.cast = credit.cast
            self.crew = credit.crew
            
            self.movieInfoTableView.reloadData()
        }
        
        switch type {
        case .movie:
            TmdbAPIManager.shared.fetchMovieDetails(id: id) { details in
                print(details)
            }
        case .tv:
            TmdbAPIManager.shared.fetchTvDetails(id: id) { details in
                self.detail = details
            }
        }
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let content = self.content else { return 0 }
        return content.mediaType == .movie ? ContentInfo.allCases.count - 1 : ContentInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return cast.count
        case 2: return crew.count
        case 3: return 1
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
            cell.expandCell(isExpand: isExpand)
            
            cell.delegate = self
            cell.indexPath = indexPath
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(row: cast[indexPath.row])
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(row: crew[indexPath.row])
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonTableViewCell.identifier) as? SeasonTableViewCell else { return UITableViewCell() }
            
            cell.details = self.detail
            
            cell.configureCell()
            
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            isExpand.toggle()
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        case 1, 2: return 90
        case 3: return 500
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContentInfo.allCases[section].text
    }
    
}

extension DetailViewController: moreOverviewButtonTappedDelegate {

    func buttonTapped(index: IndexPath) {
        isExpand.toggle()
        movieInfoTableView.reloadRows(at: [index], with: .none)
    }

}

extension DetailViewController {
    
    func configureView() {
        configureNavigationBar()
        configureTableView()
        configureTableViewHeader()
        
        setData()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func configureTableView() {
        movieInfoTableView.delegate = self
        movieInfoTableView.dataSource = self

        let overviewCellNib = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        movieInfoTableView.register(overviewCellNib, forCellReuseIdentifier: OverviewTableViewCell.identifier)
        
        let CastCellnib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        movieInfoTableView.register(CastCellnib, forCellReuseIdentifier: CastTableViewCell.identifier)
        
        let seasonCellNib = UINib(nibName: SeasonTableViewCell.identifier, bundle: nil)
        movieInfoTableView.register(seasonCellNib, forCellReuseIdentifier: SeasonTableViewCell.identifier)
    }
    
    func configureTableViewHeader() {
        backdropImageView.contentMode = .scaleToFill
    }
    
    func setData() {
        guard let content = self.content else { return }
        
        if let backdrop = content.backdropPath {
            let path = URL(string: URL.imageURL + backdrop)
            backdropImageView.kf.setImage(with: path)
        }
        
        titleLabel.text = content.title != nil ? content.title : content.name
        
        if let poster = content.posterPath {
            let path = URL(string: URL.imageURL + poster)
            posterImageView.kf.setImage(with: path)
        }
    }
    
}
