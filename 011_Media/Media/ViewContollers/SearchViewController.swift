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
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text else { return }
        TmdbAPIManager.shared.fetchSearch(title: title) { movies in
            self.movies = movies
            
            self.resultTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        movies.removeAll()
        
        resultTableView.reloadData()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }

        vc.movie = movies[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

extension SearchViewController {
    
    func configureSearchBar() {
        seachBar.setValue("취소", forKey: "cancelButtonText")
        seachBar.setShowsCancelButton(true, animated: true)
        seachBar.placeholder = "영화를 찾아보세요"
    }
    
    func configureTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        
        resultTableView.rowHeight = 130
        
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
}
