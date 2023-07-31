//
//  BookshelfCollectionViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/07/31.
//

import UIKit

class BookshelfCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "BookshelfCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookshelfCollectionViewCell")
    }

}
