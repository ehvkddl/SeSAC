//
//  ViewController.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/09.
//

import UIKit
import Alamofire
import RealmSwift

class BookshelfViewController: UIViewController {

    var books: [Book] = []
    var page = 1
    var isEnd = false
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        bookCollectionView.prefetchDataSource = self
        
        let nib = UINib(nibName: BookshelfCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nib, forCellWithReuseIdentifier: BookshelfCollectionViewCell.identifier)
        
        bookCollectionViewLayout()
    }

    func callRequest(query: String, page: Int) {
        guard let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakaoKey)"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let document = try JSONDecoder().decode(Document.self, from: data)

                    let contents = document.documents
                    
                    self.isEnd = document.meta.isEnd
                    self.books += contents
                    
                    self.bookCollectionView.reloadData()
                } catch {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension BookshelfViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        books.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
        
        searchBar.resignFirstResponder()
    }
    
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookshelfCollectionViewCell.identifier, for: indexPath) as? BookshelfCollectionViewCell else { return UICollectionViewCell() }
        
        cell.book = books[indexPath.row]
        cell.configureCell(row: books[indexPath.row])
        
        cell.bookmarkButtonClickedClosure = { book in
            guard let book = book else { return }
            
            let realm = try! Realm()
            
            let bookmarks = realm.objects(Bookmark.self)
            
            let sameBook = bookmarks.where {
                $0.isbn == book.isbn
            }
            
            guard sameBook.isEmpty else {
                let alert = UIAlertController(title: "📚", message: "동일한 책이 이미 북마크 되어있어요!", preferredStyle: .alert)
                let ok = UIAlertAction(title: "알겠어요", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: true)
                
                return
            }
            
            var authors = List<String>()
            book.authors.forEach { authors.append($0) }
            
            var translators = List<String>()
            book.translators.forEach { translators.append($0) }
            
            let task = Bookmark(authors: authors,
                                contents: book.contents,
                                datetime: book.datetime,
                                isbn: book.isbn,
                                price: book.price,
                                publisher: book.publisher,
                                salePrice: book.salePrice,
                                status: book.status,
                                thumbnail: book.thumbnail,
                                title: book.title,
                                translators: translators,
                                url: book.url)
            
            try! realm.write {
                realm.add(task)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
                
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        vc.content = books[indexPath.row]
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .overFullScreen
        
        present(nav, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if books.count - 1 == indexPath.row && page < 50 {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}

extension BookshelfViewController {
    
    func bookCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        
        bookCollectionView.collectionViewLayout = layout
    }
    
}
