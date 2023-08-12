//
//  ViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendCollectionView: UICollectionView!
    
    var trends: [Trend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        
        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        trendCollectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        
        trendCollectionViewLayout()
        
        TmdbAPIManager.shared.fetchTrend(completionHandler: { trend in
            self.trends = trend.results
            self.trendCollectionView.reloadData()
        })
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }

        cell.delegate = self
        cell.index = indexPath.row
        cell.configureCell(row: trends[indexPath.row])
        
        return cell
    }
    
}

extension TrendViewController: ButtonTappedDelegate {
    func cellButtonTapped(index: Int) {
        print("\(index) Button Tapped")
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
