//
//  ViewController.swift
//  LEDBoard
//
//  Created by do hee kim on 2023/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var returnButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designComponent()
    }

}

extension ViewController {
    func designComponent() {
        view.backgroundColor = .black
        
        designReturnBtn(button: returnButton)
        designResultLabel(label: resultLabel)
    }
    
    func designReturnBtn(button: UIButton) {
        button.tintColor = .black

        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5
    }
    
    func designResultLabel(label: UILabel) {
        label.text = "외치기!!!!"
        
        label.textAlignment = .center
        label.textColor = .white
        
        label.numberOfLines = 0
    }
}
