//
//  VideoTableViewCell.swift
//  Media
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet var videoCollectionView: UICollectionView!
    
    var videos: [Video]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension VideoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let videos = self.videos else { return 0 }
        
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
        
        guard let videos = self.videos else { return UICollectionViewCell() }
        cell.configureCell(video: videos[indexPath.row])
        cell.backgroundColor = UIColor(red: CGFloat(Int.random(in: 0...1)), green: CGFloat(Int.random(in: 0...1)), blue: CGFloat(Int.random(in: 0...1)), alpha: 1)
        
        return cell
    }
    
}

extension VideoTableViewCell {
    
    func configureCell(videos: [Video]) {
        self.videos = videos
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        
        let nib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        videoCollectionView.register(nib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        
        videoCollectionView.showsHorizontalScrollIndicator = false
        
        videoCollectionViewLayout()
    }
    
    func videoCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 1
        let width = UIScreen.main.bounds.width * (4 / 5)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: width * (3 / 4))
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = spacing
        
        videoCollectionView.collectionViewLayout = layout
    }
    
}
