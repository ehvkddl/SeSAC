//
//  VideoTableViewCell.swift
//  Media
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var videoCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension VideoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

extension VideoTableViewCell {
    
    func configureCell() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        
        let nib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        videoCollectionView.register(nib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        
        videoCollectionViewLayout()
    }
    
    func videoCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        let width = UIScreen.main.bounds.width * (3 / 4)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * (300 / 533))
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        
        videoCollectionView.collectionViewLayout = layout
    }
    
}
