//
//  LoginTextField.swift
//  Netfilx
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(placeholder: String) {
        backgroundColor = .gray
        textColor = .white
        attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [.foregroundColor: UIColor.systemGray4])
        textAlignment = .center
        layer.cornerRadius = 5
        
        self.placeholder = placeholder
    }
    
}
