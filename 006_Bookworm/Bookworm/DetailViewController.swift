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
    
    let placeholderText = "메모를 추가해주세요."
    
    var content: Book?
    var isBookmark = false
    
    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookTitleLabel: UILabel!
    
    @IBOutlet var bookInfoLabel: UILabel!
    
    @IBOutlet var bookPriceLabel: UILabel!
    @IBOutlet var bookSalePriceLabel: UILabel!
    
    @IBOutlet var bookContentsLabel: UILabel!
    
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = content?.title
        
        memoTextView.delegate = self
        
        configureNavigation()
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
        
        if !isBookmark {
            memoTextView.isHidden = true
            return
        }
        
        memoTextView.text = placeholderText
        memoTextView.textColor = .lightGray
    }

}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
extension DetailViewController {
    
    func configureNavigation() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        if isBookmark {
            let editItem = UIAction(title: "수정", image: UIImage(systemName: "pencil")) { action in
                print("edit button")
            }
            
            let deleteItem = UIAction(title: "삭제", image: UIImage(systemName: "trash")) { action in
                print("delete button")
            }
            
            let menu = UIMenu(title: "", image: nil, options: .displayInline, children: [editItem, deleteItem])
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), target: self, action: nil, menu: menu)
        }
    }
    
}
