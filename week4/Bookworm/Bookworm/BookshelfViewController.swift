//
//  ViewController.swift
//  Bookworm
//
//  Created by do hee kim on 2023/08/09.
//

import UIKit
import Alamofire

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
    }
    
}

extension BookshelfViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookshelfCollectionViewCell.identifier, for: indexPath) as? BookshelfCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(row: books[indexPath.row])
        
        return cell
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
