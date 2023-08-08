//
//  ViewController.swift
//  Lotto
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var winningNum: [Int] = []
    
    @IBOutlet var numberTextField: UITextField!
    let pickerView = UIPickerView()
    @IBOutlet var lottoNums: [UILabel]!
    @IBOutlet var bonusNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callRequest()
        designUI()
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    func callRequest() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1079"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for i in 1...6 {
                    self.winningNum.append(json["drwtNo\(i)"].intValue)
                }
                self.winningNum.append(json["bnusNo"].intValue)
                
                self.setWinningNumBall()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    func setWinningNumBall() {
        for (idx, lottoNum) in lottoNums.enumerated() {
            let num = winningNum[idx]
            
            circleBackground(lbl: lottoNum, color: setCircleColor(num: num))
            lottoNum.text = String(num)
        }
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let round = list[row]
        
        numberTextField.text = "\(round)회"
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(list[row])"
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
