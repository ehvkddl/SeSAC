//
//  BookmarkViewController.swift
//  Bookworm
//
//  Created by do hee kim on 2023/09/05.
//

import UIKit
import RealmSwift

class BookmarkViewController: UIViewController {

    @IBOutlet var bookmarkCollectionView: UICollectionView!
    
    var bookmarks: Results<Bookmark>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        self.bookmarks = realm.objects(Bookmark.self).sorted(byKeyPath: "_id", ascending: false)
        
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmarkCollectionView.reloadData()
    }
    
}

extension BookmarkViewController {
    
    func configure() {
        bookmarkCollectionView.delegate = self
        bookmarkCollectionView.dataSource = self
        
        let nib = UINib(nibName: BookshelfCollectionViewCell.identifier, bundle: nil)
        bookmarkCollectionView.register(nib, forCellWithReuseIdentifier: BookshelfCollectionViewCell.identifier)
        
        bookCollectionViewLayout()
    }
    
}

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookshelfCollectionViewCell", for: indexPath) as? BookshelfCollectionViewCell else {
            return UICollectionViewCell() }
        
        let bookmark = bookmarks[indexPath.item]
        
        var authors = [String]()
        bookmark.authors.forEach { authors.append($0)}
        
        var translators = [String]()
        bookmark.translators.forEach { translators.append($0)}

        cell.configureCell(row: Book(authors: authors,
                                     contents: bookmark.contents,
                                     datetime: bookmark.datetime,
                                     isbn: bookmark.isbn,
                                     price: bookmark.price,
                                     publisher: bookmark.publisher,
                                     salePrice: bookmark.salePrice,
                                     status: bookmark.status,
                                     thumbnail: bookmark.thumbnail,
                                     title: bookmark.title,
                                     translators: translators,
                                     url: bookmark.url))
        
        cell.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        cell.bookMarkButton.tintColor = .systemRed
        
        return cell
    }
    
}

extension BookmarkViewController {
    
    func bookCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        
        bookmarkCollectionView.collectionViewLayout = layout
    }
    
}
