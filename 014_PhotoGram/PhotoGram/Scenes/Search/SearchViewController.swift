//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
                
    }
    
}
