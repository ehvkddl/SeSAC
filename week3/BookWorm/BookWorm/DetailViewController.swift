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
        
        navigationItem.hidesBackButton = true
        
        let back = UIImage(systemName: "chevron.backward")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(backButtonClicked))
        setBarButtonItemColor(color: .black)
        
        guard let movie = contents else { return }
        title = movie.title
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
