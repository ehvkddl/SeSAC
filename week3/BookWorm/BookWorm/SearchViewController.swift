//
//  SearchViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/01.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "검색 화면"
        
        let xmark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
}
