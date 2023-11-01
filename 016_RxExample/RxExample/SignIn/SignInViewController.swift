//
//  SignInViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class signInViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let signName = {
        let tf = UITextField()
        tf.placeholder = "이름을 입력해주세요"
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let signEmail = {
        let tf = UITextField()
        tf.placeholder = "이메일을 입력해주세요"
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let signButton = {
        let btn = UIButton()
        btn.setTitle("가입하기", for: .normal)
        btn.tintColor = .systemBackground
        btn.backgroundColor = .label
        return btn
    }()
    
    let label = {
        let lbl = UILabel()
        lbl.textColor = .black
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLayout()
        setSign()
    }
    
    func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "name은 \(value1)이고, email은 \(value2)입니다"
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe(with: self) { owner, _ in
                let alert = UIAlertController(
                    title: "가입하시겠습니까?",
                    message: "이름 \(owner.signName.text!), 이메일 \(owner.signEmail.text!)",
                    preferredStyle: .alert
                )
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                let ok = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(cancel)
                alert.addAction(ok)
                
                owner.present(alert, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        [signName, signEmail, signButton, label].forEach { view.addSubview($0) }
        
        signName.snp.makeConstraints { make in
            make.bottom.equalTo(signEmail.snp.top).offset(-10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        signEmail.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        signButton.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view)
        }
    }
    
}
