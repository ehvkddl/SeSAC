//
//  ViewController.swift
//  Lotto
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let lottovm = LottoViewModel()

    lazy var roundTextField = {
        let tf = UITextField()
        tf.inputView = pickerView
        tf.textAlignment = .right
        tf.borderStyle = .roundedRect
        tf.tintColor = .clear
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
    
    lazy var balls = [ball1, ball2, ball3, ball4, ball5, ball6, bonusBall]
        
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
    
    let ball6 = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let plusLabel = {
        let lbl = UILabel()
        lbl.text = "+"
        return lbl
    }()
    
    let bonusBall = {
        let lbl = BallLabel()
        return lbl
    }()
    
    let lottoMoney = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()
    
    let tapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()
        
        lottovm.selectRound.bind { [self] num in
            roundTextField.text = lottovm.titleForSelect
            lottovm.fetch(num)
        }
        
        lottovm.data.bind { [self] lottoData in
            guard lottoData != nil else { return }
            
            let numbers = lottovm.lottoNumbers
            
            DispatchQueue.main.async { [self] in
                self.balls.enumerated().forEach { index, item in
                    item.setBall(num: numbers[index])
                }
                
                lottoMoney.text = lottovm.lottoMoney
            }
        }
    }

    func configureView() {
        [ball1, ball2, ball3, ball4, ball5, ball6, plusLabel, bonusBall].forEach { stackView.addArrangedSubview($0)}
        [roundTextField, stackView, lottoMoney].forEach{ view.addSubview($0) }
        view.addGestureRecognizer(tapGestureRecognizer)
        
        tapGestureRecognizer.addTarget(self, action: #selector(didTapView))
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
                make.size.equalTo(45)
            }
        }
        
        lottoMoney.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottovm.numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lottovm.selectRound.value = lottovm.round[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lottovm.titleForRow(row)
    }
    
}
