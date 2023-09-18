//
//  conditionLabel.swift
//  Netfilx
//
//  Created by do hee kim on 2023/09/18.
//

import UIKit

class ConditionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        textColor = .red
        font = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
