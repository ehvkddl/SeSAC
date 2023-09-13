//
//  ViewController.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {

    let round: [Int] = (1...1084).reversed()
    
    lazy var roundTextField = {
        let tf = UITextField()
        tf.inputView = pickerView
        tf.text = "\(round.first ?? 0)회"
        tf.textAlignment = .right
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var pickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let stackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var balls = [ball1, ball2, ball3, ball4, ball5, bonusBall]
        
    let ball1 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let ball2 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let ball3 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let ball4 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let ball5 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let bonusBall = {
        let lbl = BallLabel()
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()
    }

    func configureView() {
        balls.forEach { stackView.addArrangedSubview($0) }
        [roundTextField, stackView].forEach{ view.addSubview($0) }
    }
    
    func setConstraints() {
        roundTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.trailing.equalTo(view).inset(16)
            make.width.equalTo(70)
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(roundTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view).inset(16)
        }
        
        balls.forEach {
            $0.snp.makeConstraints { make in
                make.size.equalTo(50)
            }
        }
    }

}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return round.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roundTextField.text = "\(round[row])회"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(round[row])"
    }
    
}
