//
//  ViewController.swift
//  NewlyCoinedWord
//
//  Created by do hee kim on 2023/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    let coinedWords: [String: String] = [
        "농협은행": "시초에는 초행길이었던 외국인이 농협은행이 어디있는지 길을 묻는 과정에서 '농협은행 어디있어요?'를 '너무 예쁘네요'라고 오해했고 지금은 너무 예쁘다 라는 밈으로 주로 사용되고 있습니다.",
        "점메추": "점심 메뉴 추천의 줄임말입니다",
        "H워얼V": "'사랑해'라는 글자를 뒤집은 모습으로 영문 H와 V를 이용한 신조어입니다.",
        "통모짜핫도그": "'통모짜'를 '통 못 자'로 표현하며 요즘 통 못 자서 피곤한 상태임을 의미하는 말입니다.",
        "요즘잘자쿨냥이": "통모짜핫도그를 직역하게 되면 '뜨거운 강아지'라는 의미가 된다. 따라서 반대로 '차가운 고양이'를 뜻하는 의미 '쿨냥이'가 나왔고, '나 요즘 잘 잔다'는 것을 뜻하는 말로 요즘잘자쿨냥이를 사용하게 되었습니다.",
        "-겠냐": "바라는 일이 있으나, 현실적으로 이루어질 수 없을 때 사용함.",
        "제당슈만": "제가 당신을 슈퍼스타로 만들어 드릴게요.",
        "짜짜": "진짜",
        "박박": "대박",
        "SBN": "선배님"
    ]

    @IBOutlet var textField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var wordButtons: [UIButton]!
    @IBOutlet var refreshButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designComponent()
        setWord(buttons: wordButtons)
    }

    @IBAction func textFieldKeyboardTapped(_ sender: UITextField) {
        setLabel(label: resultLabel, word: textField.text ?? "")
    }
    
    @IBAction func searchBtnTapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        textFieldKeyboardTapped(textField)
    }
    
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        textField.text = sender.currentTitle!
        setLabel(label: resultLabel, word: sender.currentTitle!)
    }
    
    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        setWord(buttons: wordButtons)
    }
    
    func chooseWord() -> [String] {
        var words: Set<String> = []
        
        while words.count < 5 {
            words.insert(coinedWords.randomElement()?.key ?? "단어 없음")
        }
        
        return Array(words)
    }
    
    func setWord(buttons: [UIButton]) {
        let words: [String] = chooseWord()
        
        for (idx, button) in buttons.enumerated() {
            button.setTitle(words[idx], for: .normal)
        }
    }
    
    func setLabel(label: UILabel, word: String) {
        guard let meaning = coinedWords[word] else {
            label.text = "단어를 찾을 수 없습니다."
            return
        }
        
        label.text = meaning
    }
}

extension ViewController {
    
    func designComponent() {
        designTextField(textField: textField)
        designSearchBtn(button: searchButton)
        
        for btn in wordButtons {
            designWordBtn(button: btn)
        }
        
        designRefreshBtn(button: refreshButton)
        
        designLabel(label: resultLabel)
    }
    
    func designSearchBtn(button: UIButton) {
        button.backgroundColor = .black
        button.tintColor = .white

        button.layer.cornerRadius = 5

        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "return"), for: .normal)
    }
    
    func designTextField(textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 5
    }
    
    func designWordBtn(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        
        button.setTitleColor(.black, for: .normal)
    }
    
    func designRefreshBtn(button: UIButton) {
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        
        button.layer.cornerRadius = 5
        
        button.backgroundColor = .black
        button.tintColor = .white
    }
    
    func designLabel(label: UILabel) {
        label.text = "알고 싶은 단어를 검색해주세요."
        label.backgroundColor = .white

        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 5

        label.textAlignment = .center
        label.numberOfLines = 0

        label.layer.shadowOffset = CGSize(width: 10, height: 10)
        label.layer.shadowRadius = 3
        label.layer.shadowOpacity = 0.5
        label.clipsToBounds = false
    }
    
}


