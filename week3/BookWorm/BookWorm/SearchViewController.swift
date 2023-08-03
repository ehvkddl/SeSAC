//
//  SearchViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/01.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    var movies: [Movie] = []
    var searchMovie: [Movie] = [] {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        let xmark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        setBarButtonItemColor(color: .black)
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        let nib = UINib(nibName: "BookshelfCollectionViewCell", bundle: nil)
        
        searchCollectionView.register(nib, forCellWithReuseIdentifier: "BookshelfCollectionViewCell")
        
        searchCollectionViewLayout()
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovie.removeAll()
        
        for movie in movies {
            if movie.title.contains(searchBar.text!) {
                searchMovie.append(movie)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchMovie.removeAll()
        searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovie.removeAll()
        
        for movie in movies {
            if movie.title.contains(searchText) {
                searchMovie.append(movie)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookshelfCollectionViewCell", for: indexPath) as? BookshelfCollectionViewCell else { return UICollectionViewCell()}
        
        let row = searchMovie[indexPath.row]
        cell.configureCell(row: row, type: .search)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        vc.contents = searchMovie[indexPath.row]
        vc.transition = .present
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func searchCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)

        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 2.0)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        searchCollectionView.collectionViewLayout = layout
    }
    
}
