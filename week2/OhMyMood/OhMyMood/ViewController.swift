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
        addScore(idx: sender.tag, score: 1)
    }
    
    func addScore(idx: Int, score: Int) {
        emotionScore[idx] += score
        
        guard let emotion = Emotion(rawValue: idx) else { return }
        UserDefaults.standard.setValue(emotionScore[idx], forKey: emotion.text)
        
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
    
    func resetScore(idx: Int) {
        emotionScore[idx] = 0
        
        guard let emotion = Emotion(rawValue: idx) else { return }
        UserDefaults.standard.setValue(emotionScore[idx], forKey: emotion.text)
        
        printScore()
    }
    
}

extension ViewController {
    
    func designComponent() {
        emotionButtons.forEach { button in
            designEmotionBtn(button: button)
            setBtnMenu(button: button)
        }
    }
    
    func designEmotionBtn(button: UIButton) {
        guard let emotion = Emotion(rawValue: button.tag) else { return }
        
        button.backgroundColor = UIColor(named: emotion.text)
        button.setImage(UIImage(named: emotion.text), for: .normal)
    }
    
    func setBtnMenu(button: UIButton) {
        let fiveScore = UIAction(title: "+5",
                                 image: UIImage(systemName: "5.circle"),
                                 handler: { _ in self.addScore(idx: button.tag, score: 5) })
        
        let tenScore = UIAction(title: "+10",
                                image: UIImage(systemName: "10.circle"),
                                handler: { _ in self.addScore(idx: button.tag, score: 10) })
        
        let resetScore = UIAction(title: "reset",
                                  image: UIImage(systemName: "wand.and.stars"),
                                  handler: { _ in self.resetScore(idx: button.tag)})
        
        button.menu = UIMenu(title: "score",
                             options: .displayInline,
                             children: [fiveScore, tenScore, resetScore])
    }
    
}
