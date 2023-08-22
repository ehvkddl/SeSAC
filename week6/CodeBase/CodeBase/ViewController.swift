//
//  ViewController.swift
//  CodeBase
//
//  Created by do hee kim on 2023/08/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let example1Button = {
        let button = UIButton()
        
        button.setTitle("example 1", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    }


}

extension ViewController {
    
    func configureUI() {
        [example1Button, example2Button, example3Button].forEach { view.addSubview($0) }
        
        
        // MARK: SnapKit
        example1Button.snp.makeConstraints { make in
            make.bottom.equalTo(example2Button.snp.top).offset(-80)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(80)
        }

    }
    
}
