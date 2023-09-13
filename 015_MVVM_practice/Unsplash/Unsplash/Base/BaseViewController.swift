//
//  BaseViewController.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        setNavigationBar()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() { }
    
    func setNavigationBar() { }
    
}
