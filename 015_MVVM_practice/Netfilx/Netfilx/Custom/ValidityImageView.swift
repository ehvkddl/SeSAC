//
//  ValidityButton.swift
//  Netfilx
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class ValidityImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValid() {
        image = UIImage(systemName: "checkmark.circle")
        tintColor = .green
    }
    
    func setInvalid() {
        image = UIImage(systemName: "xmark.circle")
        tintColor = .red
    }
    
    
}
