//
//  BallLabel.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/14.
//

import UIKit

class BallLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "0"
        textAlignment = .center
        textColor = .white
        font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        backgroundColor = .lightGray
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.width * 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurelabel() {
        text = "0"
        backgroundColor = .lightGray
        layer.cornerRadius = frame.width * 0.5
    }
    
    func setBall(num: Int) {
        text = "\(num)"
        backgroundColor = ballColor(num: num)
    }
    
    func ballColor(num: Int) -> UIColor{
        switch num {
        case 1...9: return UIColor.LTYellow
        case 10...19: return UIColor.LTBlue
        case 20...29: return UIColor.LTRed
        case 30...39: return UIColor.LTGray
        case 40...45: return UIColor.LTGreen
        default: return .gray
        }
    }
    
}
