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
    
    @IBOutlet var bookMarkButton: UIButton!
    
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!
    @IBOutlet var bookPriceLabel: UILabel!
    
    var bookmarkButtonClickedClosure: ((Book?, UIImage?) -> Void)?
    
    var book: Book?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    @IBAction func bookMarkButtonClicked(_ sender: UIButton) {
        
        bookmarkButtonClickedClosure?(book, bookImageView.image)
        
    }
    
    func configureCell(row: Book) {
        print("cellcellcell")
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
