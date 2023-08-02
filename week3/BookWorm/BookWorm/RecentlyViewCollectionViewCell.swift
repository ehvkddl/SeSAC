//
//  RecentlyViewCollectionViewCell.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/02.
//

import UIKit

class RecentlyViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentlyViewCollectionViewCell"
    
    @IBOutlet var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(row: Movie) {
        moviePosterImageView.image = UIImage(named: row.title)
    }

}
