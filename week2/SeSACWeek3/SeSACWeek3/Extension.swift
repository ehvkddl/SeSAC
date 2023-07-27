//
//  Extension.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/27.
//

import UIKit

extension UITableViewController {
    func showAlert() {
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UILabel {
    func configureTitleText() {
        self.textColor = .red
        self.font = .boldSystemFont(ofSize: 20)
        self.textAlignment = .center
    }
}
