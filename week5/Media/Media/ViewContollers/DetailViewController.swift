//
//  DetailViewController.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var movieTableView: UITableView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }

    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
    
}
