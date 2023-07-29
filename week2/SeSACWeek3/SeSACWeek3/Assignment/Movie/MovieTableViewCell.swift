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
    
}
