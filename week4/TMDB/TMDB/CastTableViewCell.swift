//
//  CastTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/13.
//

import UIKit
import Kingfisher

class CastTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(row: Cast) {
        if let path = row.profilePath {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)") else { return }
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "blankProfile")
        }
        
        nameLabel.text = row.name
        characterLabel.text = row.character
    }
    
}
