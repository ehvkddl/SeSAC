//
//  BrowseViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {

    @IBOutlet var recentlyViewCollectionView: UICollectionView!
    @IBOutlet var popularWorkTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
