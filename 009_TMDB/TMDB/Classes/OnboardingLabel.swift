//
//  OnboardingLabel.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/27.
//

import UIKit

class OnboardingLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(text: String) {
        self.text = text
        textAlignment = .center
        textColor = .white
        numberOfLines = 0
    }
    
}
