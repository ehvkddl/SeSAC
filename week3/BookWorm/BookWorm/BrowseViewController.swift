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
        
        let nib = UINib(nibName: RecentlyViewCollectionViewCell.identifier, bundle: nil)
        recentlyViewCollectionView.register(nib, forCellWithReuseIdentifier: RecentlyViewCollectionViewCell.identifier)
        
        configureRecentlyViewCollectionViewLayout()
        recentlyViewCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
    
}
