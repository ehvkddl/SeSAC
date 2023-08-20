//
//  VideoCollectionViewCell.swift
//  Media
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension VideoCollectionViewCell {
    
    func configureCell(video: Video) {
        let url = URL(string: getYtThumbnailURL(of: video.key))
        thumbnailImageView.kf.setImage(with: url)
    }
    
}

extension VideoCollectionViewCell {
    
    func getYtThumbnailURL(of key: String) -> String {
        return "https://img.youtube.com/vi/\(key)/0.jpg"
    }
    
}
