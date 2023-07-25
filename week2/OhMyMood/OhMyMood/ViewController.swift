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
}

class ViewController: UIViewController {
    @IBOutlet var emotionButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designComponent()
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
