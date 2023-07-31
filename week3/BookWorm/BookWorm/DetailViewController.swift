//
//  DetailViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/01.
//

import UIKit

class DetailViewController: UIViewController {

    var contents: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = contents else { return }
        title = movie.title
    }
    

}
