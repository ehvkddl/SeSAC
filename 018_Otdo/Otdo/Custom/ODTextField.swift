//
//  ODTextField.swift
//  Otdo
//
//  Created by do hee kim on 2023/11/28.
//

import UIKit

class ODTextField: UITextField {
    
    init(placeholderText: String) {
        super.init(frame: .zero)
        
        placeholder = placeholderText
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
