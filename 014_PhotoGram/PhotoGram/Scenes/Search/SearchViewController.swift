//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var photos: [PhotoResult] = []
    
    var imageSendClosure: ((String) -> Void)?
    
    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        mainView.searchBar.delegate = self
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let serchWord = searchBar.text, serchWord != "" else { return }
        UnsplashAPIManager.shared.fetchPhotos(of: serchWord) { photos in
            self.photos = photos
            
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        let thumbUrl = photos[indexPath.item].urls.thumb
        cell.imageView.load(from: thumbUrl)
        
        return cell
                
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thumbUrl = photos[indexPath.item].urls.thumb
        
        self.imageSendClosure?(thumbUrl)
        
        dismiss(animated: true)
    }
    
}
