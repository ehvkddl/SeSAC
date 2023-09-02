//
//  PopularWorkTableViewCell.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/02.
//

import UIKit

class PopularWorkTableViewCell: UITableViewCell {

    static let identifier = "PopularWorkTableViewCell"
    
    @IBOutlet var moviePosterImageView: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var runtimeAndRateLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        releaseDateLabel.textColor = .gray
    }

    func configureCell(row: Movie) {
        print(row)
        moviePosterImageView.image = UIImage(named: row.title)
        
        movieTitleLabel.text = row.title
        runtimeAndRateLabel.text = "\(row.runtime)분 | ⭐️\(row.rate)"
        releaseDateLabel.text = "\(row.releaseDate) 개봉"
    }
    
}
