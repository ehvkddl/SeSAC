//
//  Extension+UIColor.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/09.
//

import UIKit

extension UIColor {
    
    static let BRPaleStraw = UIColor(named: "BRPaleStraw")!
    static let BRStraw = UIColor(named: "BRStraw")!
    static let BRPaleGold = UIColor(named: "BRPaleGold")!
    static let BRDeepGold = UIColor(named: "BRDeepGold")!
    static let BRPaleAmber = UIColor(named: "BRPaleAmber")!
    static let BRMediumAmber = UIColor(named: "BRMediumAmber")!
    static let BRDeepAmber = UIColor(named: "BRDeepAmber")!
    static let BRAmberBrown = UIColor(named: "BRAmberBrown")!
    static let BRBrown = UIColor(named: "BRBrown")!
    static let BRRubyBrown = UIColor(named: "BRRubyBrown")!
    static let BRDeepBrown = UIColor(named: "BRDeepBrown")!
    static let BRBlack = UIColor(named: "BRBlack")!
    
    static func getBeerColor(srm: Double) -> UIColor {
        let srmInt = Int(srm)
        
        switch srmInt {
        case 1...2: return .BRPaleStraw
        case 3: return .BRStraw
        case 4: return .BRPaleGold
        case 5...6: return .BRDeepGold
        case 7...9: return .BRPaleAmber
        case 10...12: return .BRMediumAmber
        case 13...15: return .BRDeepAmber
        case 16...18: return .BRAmberBrown
        case 19...20: return .BRBrown
        case 21...24: return .BRRubyBrown
        case 25...30: return .BRDeepBrown
        case 31...: return .BRBlack
        default: return .clear
        }
    }
    
}
