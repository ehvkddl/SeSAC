//
//  HeaderSeasonCollectionReusableView.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/19.
//

import UIKit

class HeaderSeasonCollectionReusableView: UICollectionReusableView {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(row: Season) {
        nameLabel.text = row.name
        infoLabel.text = "\(row.voteAverage) • \(row.airDate) • \(row.episodeCount)화" // "평점 공개일 에피소드개수"
    }
    
}
