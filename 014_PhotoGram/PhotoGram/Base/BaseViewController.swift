//
//  BaseViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
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
        view.backgroundColor = .white
    }
    
    func setConstraints() { }

    func configureNavigationBar() { }
    
}
