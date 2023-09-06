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
    
    let realm = try! Realm()
    
    var bookmarks: Results<Bookmark>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.bookmarks = realm.objects(Bookmark.self).sorted(byKeyPath: "_id", ascending: false)
        
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookmarkCollectionView.reloadData()
    }
    
    func convertToBook(using bookmark: Bookmark) -> Book {
        var authors = [String]()
        bookmark.authors.forEach { authors.append($0)}
        
        var translators = [String]()
        bookmark.translators.forEach { translators.append($0)}
        
        let book = Book(authors: authors,
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
                        url: bookmark.url)
        
        return book
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookshelfCollectionViewCell.identifier, for: indexPath) as? BookshelfCollectionViewCell else {
            return UICollectionViewCell() }
        
        let book = convertToBook(using: bookmarks[indexPath.item])

        cell.configureCell(row: book)
        
        cell.bookmarkButtonClickedClosure = { _ in
            let data = self.bookmarks[indexPath.item]

            try! self.realm.write {
                self.realm.delete(data)
            }
            
            collectionView.reloadData()
        }
        
        cell.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        cell.bookMarkButton.tintColor = .systemRed
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = convertToBook(using: bookmarks[indexPath.item])
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
                
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.content = book
        vc.isBookmark = true
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .overFullScreen
        
        present(nav, animated: true)
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
