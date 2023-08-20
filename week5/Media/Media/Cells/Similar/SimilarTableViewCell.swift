//
//  SimilarTableViewCell.swift
//  Media
//
//  Created by do hee kim on 2023/08/20.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
