//
//  CustomTableViewCell.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let indentifier = "CustomTableViewCell"
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var checkboxImageView: UIImageView!
    
    @IBOutlet var mainTitleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    func configureCell(row: ToDo) {
        mainTitleLabel.text = row.main
        subTitleLabel.text = row.sub
        
        let checkboxImage = UIImage(systemName: row.done ? "checkmark.square.fill" : "square")
        checkboxImageView.image = checkboxImage
        
        let likeImage = UIImage(systemName: row.like ? "star.fill" : "star")
        likeButton.setImage(likeImage, for: .normal)
    }
    
}
