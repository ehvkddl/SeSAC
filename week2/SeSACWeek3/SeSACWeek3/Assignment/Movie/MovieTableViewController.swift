//
//  MovieTableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/29.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    var movieInfo = MovieInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell else { return MovieTableViewCell() }
        
        let row = movieInfo.movie[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }

}
