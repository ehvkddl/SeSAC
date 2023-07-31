//
//  BookshelfCollectionViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/07/31.
//

import UIKit

class BookshelfCollectionViewController: UICollectionViewController {

    let user = "찹쌀"
    let movieInfo = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(user)님의 상영관"
        
        let nib = UINib(nibName: "BookshelfCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookshelfCollectionViewCell")
        
        searchCollectionViewLayout()
    }
    
    func searchCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)

        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 2.0)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookshelfCollectionViewCell", for: indexPath) as? BookshelfCollectionViewCell else { return UICollectionViewCell() }
        
        let row = movieInfo.movie[indexPath.row]
        cell.configureCell(row: row)
        
        return cell
    }
    
}
