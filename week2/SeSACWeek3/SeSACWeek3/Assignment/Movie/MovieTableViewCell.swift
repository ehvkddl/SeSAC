//
//  MovieTableViewCell.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/29.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "MovieTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        
        releaseDateLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        runtimeLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        rateLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    func configureCell(row: Movie) {
        posterImageView.image = UIImage(named: row.title)
        
        titleLabel.text = row.title
        
        releaseDateLabel.text = row.releaseDate
        runtimeLabel.text = "\(row.runtime)분"
        rateLabel.text = "\(row.rate)점"
        
        overviewLabel.text = row.overview
    }
    
}
