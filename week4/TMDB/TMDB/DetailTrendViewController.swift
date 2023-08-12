//
//  DetailTrendViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/13.
//

import UIKit

class DetailTrendViewController: UIViewController {

    var content: Trend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
    }

}
