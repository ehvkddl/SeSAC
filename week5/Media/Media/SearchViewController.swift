//
//  ViewController.swift
//  Media
//
//  Created by do hee kim on 2023/08/19.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var seachBar: UISearchBar!
    @IBOutlet var resultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension SearchViewController {
    
    func configureTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
    }
    
}
