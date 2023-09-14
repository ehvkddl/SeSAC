//
//  WriteTextField.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/15.
//

import UIKit

class WriteTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        backgroundColor = .white
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }

}
