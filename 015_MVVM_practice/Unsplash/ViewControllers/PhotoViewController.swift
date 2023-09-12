//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class PhotoViewController: BaseViewController {

    var vm = PhotoViewModel()
    
    lazy var searchController = {
        let view = UISearchController(searchResultsController: SearchResultViewController(vm: self.vm))
        view.searchBar.delegate = self
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

extension PhotoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        vm.fetchPhoto(of: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vm.reset()
    }

}
