//
//  BaseViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/29.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() { }

}
