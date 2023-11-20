//
//  BaseViewController.swift
//  Otdo
//
//  Created by do hee kim on 2023/11/21.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        configureNavigationBar()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {}
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = Constants.Color.accent
    }
    
}
