//
//  DetailTrendViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/13.
//

import UIKit

class DetailTrendViewController: UIViewController {

    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var overViewButton: UIButton!
    
    @IBOutlet var castTableView: UITableView!
    
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
            
            self.castTableView.reloadData()
        }
    }
    
    @IBAction func moreOverViewButtonTapped(_ sender: UIButton) {
        isDetailed.toggle()
        
        if isDetailed {
            overViewLabel.numberOfLines = 0
            overViewButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            overViewLabel.numberOfLines = 2
            overViewButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        configureNavigationBar()
        configureOverViewLabel()
        configureTableView()
        
        setData()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func configureOverViewLabel() {
        overViewLabel.numberOfLines = 2
    }
    
    func configureTableView() {
        castTableView.delegate = self
        castTableView.dataSource = self
        
        castTableView.isScrollEnabled = false
        castTableView.rowHeight = 75
        
        let nib = UINib(nibName: CastTableViewCell.identifier, bundle: nil)
        castTableView.register(nib, forCellReuseIdentifier: CastTableViewCell.identifier)
    }

    func setData() {
        guard let content = self.content else { return }
        
        let backdrop = URL(string: URL.imageURL + content.backdropPath)
        backdropImageView.kf.setImage(with: backdrop)
        
        titleLabel.text = content.title != nil ? content.title : content.name
        
        let poster = URL(string: URL.imageURL + content.posterPath)
        posterImageView.kf.setImage(with: poster)
        
        overViewLabel.text = content.overview
    }
    
}

extension DetailTrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier) as? CastTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(row: cast[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
