//
//  BookshelfCollectionViewCell.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/10.
//

import UIKit
import Kingfisher

class BookshelfCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookshelfCollectionViewCell"
    
    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!
    @IBOutlet var bookPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    func configureCell(row: Book) {
        if let url = URL(string: row.thumbnail) {
            bookImageView.kf.setImage(with: url)
        }
        
        bookTitleLabel.text = row.title
        bookInfoLabel.text = row.info
        bookPriceLabel.text = "\(row.price)원"
    }
    
    func designCell() {
        bookTitleLabel.numberOfLines = 3
    }

}
