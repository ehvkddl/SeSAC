//
//  DetailViewController.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import UIKit

enum DetailViewSection: String, CaseIterable {
    case video = "Video"
    case similar = "Similar"
}

class DetailViewController: UIViewController {

    @IBOutlet var movieTableView: UITableView!
    
    var movie: Movie?
    
    var videos: [Video]?
    var similars: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        getData()
    }

    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DetailViewSection.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let videos = self.videos else { return 0 }

            return videos.count
        case 1:
            guard let similars = self.similars else { return 0 }

            return similars.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension DetailViewController {
    
    func configureNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }
    
    func configureTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        let videoNib = UINib(nibName: VideoTableViewCell.identifier, bundle: nil)
        movieTableView.register(videoNib, forCellReuseIdentifier: VideoTableViewCell.identifier)
        
        let similarNib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        movieTableView.register(similarNib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func getData() {
        guard let movie = self.movie else { return }
        
        let group = DispatchGroup()
        
        group.enter()
        TmdbAPIManager.shared.fetchVideo(id: movie.id) { videos in
            self.videos = videos
            
            group.leave()
        }
        
        group.enter()
        TmdbAPIManager.shared.fetchSimilar(id: movie.id) { movies in
            self.similars = movies
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.movieTableView.reloadData()
        }
    }
    
}
