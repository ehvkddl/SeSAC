//
//  SwitchViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SwitchViewController: UIViewController {
    
    let testSwitch = UISwitch()
    let isOn = BehaviorSubject(value: false)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLayout()
        bind()
    }
    
    func bind() {
        isOn
            .bind(to: testSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        testSwitch.rx.isOn
            .bind(with: self) { owner, value in
                owner.isOn.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(testSwitch)
        
        testSwitch.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
}
