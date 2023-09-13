//
//  UIColor+.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/14.
//

import UIKit

extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    static let LTYellow = UIColor(hexCode: "#FBC400")
    static let LTBlue = UIColor(hexCode: "#69C9F2")
    static let LTRed = UIColor(hexCode: "#FF7172")
    static let LTGray = UIColor(hexCode: "#AAAAAA")
    static let LTGreen = UIColor(hexCode: "#B0D840")
    
}
