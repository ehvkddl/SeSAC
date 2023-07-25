//
//  StatisticsViewController.swift
//  OhMyMood
//
//  Created by do hee kim on 2023/07/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet var backgroundViews: [UIView]!
    @IBOutlet var scoreLabels: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designComponent()
    }
    


}

extension StatisticsViewController {
    func designComponent() {
        backgroundViews.forEach { view in
            setBackground(view: view)
        }
        
        scoreLabels.forEach { label in
            designLabel(label: label)
        }
    }
    
    func setBackground(view: UIView) {
        guard let emotion = Emotion(rawValue: view.tag) else { return }
        
        view.backgroundColor = UIColor(named: emotion.text)
        view.layer.cornerRadius = 10
    }
    
    func designLabel(label: UILabel) {
        label.text = "0점"
        label.font = .systemFont(ofSize: 30, weight: .medium)
    }
}
