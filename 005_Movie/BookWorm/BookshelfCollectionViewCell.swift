//
//  BookshelfCollectionViewCell.swift
//  BookWorm
//
//  Created by do hee kim on 2023/07/31.
//

import UIKit

enum ViewType {
    case main
    case search
}

class BookshelfCollectionViewCell: UICollectionViewCell {

    @IBOutlet var moviePosterImageView: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var runtimeAndRateLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }

    func configureCell(row: Movie, type: ViewType = .main) {
        moviePosterImageView.image = UIImage(named: row.title)
        
        movieTitleLabel.text = row.title
        runtimeAndRateLabel.text = "\(row.runtime)분 | ⭐️\(row.rate)점"
        releaseDateLabel.text = "\(row.releaseDate) 개봉"
        
        switch type {
        case .main:
            likeButton.setImage(UIImage(systemName: row.isLike ? "heart.fill" : "heart"), for: .normal)
        case .search:
            likeButton.isHidden = true
        }
    }
    
    func designCell() {
        movieTitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        releaseDateLabel.textColor = .gray
        
        likeButton.tintColor = .red
    }
    
}
