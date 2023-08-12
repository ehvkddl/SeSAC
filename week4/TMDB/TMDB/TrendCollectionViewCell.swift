//
//  TrendCollectionViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/12.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {

    @IBOutlet var contentsView: UIView!
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    
    @IBOutlet var backdropImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var moreDetailButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(row: Movie) {
    }
    
    func setShadow() {
    }
    
}
