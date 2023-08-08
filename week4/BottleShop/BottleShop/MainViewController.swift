//
//  ViewController.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
