//
//  ViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendCollectionView: UICollectionView!
    
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        
        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        trendCollectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        
        trendCollectionViewLayout()
        })
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieManager.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }

        cell.configureCell(row: movieManager.movies[indexPath.row])
        
        return cell
    }
    
}

extension TrendViewController {
    
    func trendCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.12)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
        layout.minimumLineSpacing = spacing
        
        trendCollectionView.collectionViewLayout = layout
    }
    
}
