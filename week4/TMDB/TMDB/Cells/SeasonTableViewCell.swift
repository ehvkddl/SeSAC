//
//  SeasonTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/19.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {

    @IBOutlet var seasonCollectionView: UICollectionView!
    
    var details: TvDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        seasonCollectionView.delegate = self
        seasonCollectionView.dataSource = self
        
        let nib = UINib(nibName: EpisodeCollectionViewCell.identifier, bundle: nil)
        seasonCollectionView.register(nib, forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        
        seasonCollectionViewLayout()
    }
    
}

extension SeasonTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let details = self.details else { return 0 }
        
        return details.numberOfSeasons
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let details = self.details else { return 0 }
        
        return details.seasons[section].episodeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell()
        
        return cell
    }
    
}

extension SeasonTableViewCell {
    
    func seasonCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        
        seasonCollectionView.collectionViewLayout = layout
    }
    
}
