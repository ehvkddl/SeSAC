//
//  EpisodeCollectionViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit
import Kingfisher

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var stillImageView: UIImageView!
    
    @IBOutlet var numAndNameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        numAndNameLabel.text = "TESTTESTTESTTESTTEST"
    }
    
}
