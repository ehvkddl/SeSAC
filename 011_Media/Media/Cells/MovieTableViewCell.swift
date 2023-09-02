//
//  MovieTableViewCell.swift
//  Media
//
//  Created by do hee kim on 2023/08/21.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension MovieTableViewCell {
    
    func configureCell(movie: Movie) {
        setData(movie: movie)
        configureLabel()
    }
    
    func setData(movie: Movie) {
        if let poster = movie.posterPath {
            let url = URL(string: URL.imageURL + poster)
            
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "photo")
        }
        
        titleLabel.text = movie.title
        infoLabel.text = "평점 \(movie.voteAverage) • \(movie.releaseDate)"
        overviewLabel.text = movie.overview
    }
    
    func configureLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        overviewLabel.textColor = .gray
        overviewLabel.font = UIFont.systemFont(ofSize: 15)
        overviewLabel.numberOfLines = 0
    }
    
}
