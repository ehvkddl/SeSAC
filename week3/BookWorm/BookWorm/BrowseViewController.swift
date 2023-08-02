//
//  BrowseViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {
    
    let movieInfo = MovieInfo()

    @IBOutlet var recentlyViewCollectionView: UICollectionView!
    @IBOutlet var popularWorkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentlyViewCollectionView.delegate = self
        recentlyViewCollectionView.dataSource = self
        
        popularWorkTableView.delegate = self
        popularWorkTableView.dataSource = self
        
        let cvNib = UINib(nibName: RecentlyViewCollectionViewCell.identifier, bundle: nil)
        recentlyViewCollectionView.register(cvNib, forCellWithReuseIdentifier: RecentlyViewCollectionViewCell.identifier)
        
        let tvNib = UINib(nibName: PopularWorkTableViewCell.identifier, bundle: nil)
        popularWorkTableView.register(tvNib, forCellReuseIdentifier: PopularWorkTableViewCell.identifier)

        configureRecentlyViewCollectionViewLayout()
        recentlyViewCollectionView.showsHorizontalScrollIndicator = false
    }
    
    func showDetailView(of indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        vc.contents = movieInfo.movie[indexPath.row]
        vc.transition = .present
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularWorkTableViewCell", for: indexPath) as? PopularWorkTableViewCell else { return UITableViewCell() }
        
        let row = movieInfo.movie[indexPath.row]
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailView(of: indexPath)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureRecentlyViewCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160 * 53 / 75, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 3
        
        recentlyViewCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentlyViewCollectionViewCell.identifier, for: indexPath) as? RecentlyViewCollectionViewCell else { return UICollectionViewCell() }
        
        let row = movieInfo.movie[indexPath.row]
        cell.configureCell(row: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailView(of: indexPath)
    }
    
}
