//
//  DetailViewController.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/10.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"
    
    var content: Book?
    
    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookTitleLabel: UILabel!
    
    @IBOutlet var bookInfoLabel: UILabel!
    
    @IBOutlet var bookPriceLabel: UILabel!
    @IBOutlet var bookSalePriceLabel: UILabel!
    
    @IBOutlet var bookContentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = content?.title
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))

        configureView()
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    func configureView() {
        guard let book = content else { return }
        
        if let url = URL(string: book.thumbnail) {
            bookImageView.kf.setImage(with: url)
        }
        
        bookTitleLabel.text = book.title
        bookInfoLabel.text = book.info
        bookPriceLabel.text = "\(book.price)원"
        bookSalePriceLabel.text = "\(book.salePrice)원"
        
        bookContentsLabel.text = book.contents
    }

}
