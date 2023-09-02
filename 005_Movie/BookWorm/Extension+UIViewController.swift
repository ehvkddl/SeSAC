//
//  Extension+UIViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/01.
//

import UIKit

extension UIViewController {
    func setBarButtonItemColor(color: UIColor) {
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationItem.rightBarButtonItem?.tintColor = color
    }
}
