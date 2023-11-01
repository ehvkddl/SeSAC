//
//  NumbersViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NumbersViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let number1 = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let number2 = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let number3 = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureLayout()
        setNumber()
    }
    
    func setNumber() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { value1, value2, value3 in
            return "\((Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0))"
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    func configureLayout() {
        [number1, number2, number3, label].forEach { view.addSubview($0) }
        
        number1.snp.makeConstraints { make in
            make.trailing.equalTo(number2.snp.leading).offset(-30)
            make.centerY.equalTo(number2)
            make.width.equalTo(20)
        }
        
        number2.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-20)
            make.width.equalTo(20)
        }
        
        number3.snp.makeConstraints { make in
            make.leading.equalTo(number2.snp.trailing).offset(30)
            make.centerY.equalTo(number2)
            make.width.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(20)
        }
    }
}
