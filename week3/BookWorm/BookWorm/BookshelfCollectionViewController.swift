//
//  BookshelfCollectionViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/07/31.
//

import UIKit

class BookshelfCollectionViewController: UICollectionViewController {

    let movieInfo = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BookshelfCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookshelfCollectionViewCell")
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookshelfCollectionViewCell", for: indexPath) as? BookshelfCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemTeal
        
        return cell
    }
    
}
