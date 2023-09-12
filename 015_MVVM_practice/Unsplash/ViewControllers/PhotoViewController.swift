//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class PhotoViewController: BaseViewController {

    let searchController = {
        let view = UISearchController(searchResultsController: SearchResultViewController())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setNavigationBar() {
        navigationItem.title = "Unsplash"
        navigationItem.searchController = searchController
    }

}


