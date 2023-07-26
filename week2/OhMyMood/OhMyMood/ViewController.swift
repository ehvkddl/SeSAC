//
//  ViewController.swift
//  OhMyMood
//
//  Created by do hee kim on 2023/07/25.
//

import UIKit

enum Emotion: Int {
    case veryHappy = 0
    case happy = 1
    case soso = 2
    case sad = 3
    case verySad = 4
    
    var text: String {
        String(describing: self)
    }
    
    var krText: String {
        switch self {
        case .veryHappy: return "완전행복지수"
        case .happy: return "적당미소지수"
        case .soso: return "그냥그냥지수"
        case .sad: return "좀속상한지수"
        case .verySad: return "많이슬픈지수"
        }
    }
}

class ViewController: UIViewController {
    
    var emotionScore: [Int] = [0, 0, 0, 0, 0]
    
    @IBOutlet var emotionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designComponent()
        
        loadScore()
    }

    @IBAction func emotionBtnClicked(_ sender: UIButton) {
        emotionScore[sender.tag] += 1
        
        guard let emotion = Emotion(rawValue: sender.tag) else { return }
        UserDefaults.standard.setValue(emotionScore[sender.tag], forKey: emotion.text)
        
        printScore()
    }
    
    func printScore() {
        for i in 0..<emotionScore.count {
            guard let emotion = Emotion(rawValue: i) else { return }
            print("\(emotion.krText): \(emotionScore[i])점")
        }
        print("=============")
    }
    
    func loadScore() {
        for i in 0..<emotionScore.count {
            guard let emotion = Emotion(rawValue: i) else { return }
            let value = UserDefaults.standard.integer(forKey: emotion.text)
            
            emotionScore[i] = value
        }
    }
    
}

extension ViewController {
    
    func designComponent() {
        emotionButtons.forEach { button in
            designEmotionBtn(button: button)
        }
    }
    
    func designEmotionBtn(button: UIButton) {
        guard let emotion = Emotion(rawValue: button.tag) else { return }
        
        button.backgroundColor = UIColor(named: emotion.text)
        button.setImage(UIImage(named: emotion.text), for: .normal)
    }
    
}
