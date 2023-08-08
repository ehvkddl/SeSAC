//
//  ViewController.swift
//  Lotto
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var lottoNums: [UILabel]!
    @IBOutlet var bonusNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designUI()
        
    }


}

extension ViewController {
    
    func designUI() {
        for lottoNum in lottoNums {
            circleBackground(lbl: lottoNum)
            designLabel(lbl: lottoNum)
        }
    }
    
    func designLabel(lbl: UILabel) {
        lbl.textColor = .white
        
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        lbl.shadowOffset = CGSize(width: 1, height: 1)
        lbl.shadowColor = .gray
    }
    
    func circleBackground(lbl: UILabel, color: UIColor = .gray) {
        lbl.backgroundColor = color
        lbl.layer.cornerRadius = lbl.frame.width / 2
        lbl.layer.masksToBounds = true
    }
    
    func setCircleColor(num: Int) -> UIColor {
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
