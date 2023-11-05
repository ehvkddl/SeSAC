//
//  SimpleValidationViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController : UIViewController {
    
    let vm = SimpleValidationViewModel()
    
    let disposeBag = DisposeBag()

    let username = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        return tf
    }()
    let usernameValidLabel = {
        let lbl = UILabel()
        return lbl
    }()

    let password = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        return tf
    }()
    let passwordValidLabel = {
        let lbl = UILabel()
        return lbl
    }()

    let doSomethingButton = {
        let btn = UIButton()
        btn.setTitle("Do Something", for: .normal)
        btn.tintColor = .systemBackground
        btn.backgroundColor = .label
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        configureLayout()
        bind()
    }

    func bind() {
        usernameValidLabel.text = "Username은 최소 \(minimalUsernameLength)글자 이상 입력해주세요."
        passwordValidLabel.text = "Password은 최소 \(minimalPasswordLength)글자 이상 입력해주세요."
        
        username.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .subscribe(with: self) { owner, value in
                owner.vm.useranmeValid.onNext(value)
            }
            .disposed(by: disposeBag)
        
        password.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .subscribe(with: self) { owner, value in
                owner.vm.passwordValid.onNext(value)
            }
            .disposed(by: disposeBag)
        
        vm.useranmeValid
            .bind(to: password.rx.isEnabled, usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        vm.passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        vm.everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    func configureLayout() {
        [username, usernameValidLabel, password, passwordValidLabel, doSomethingButton].forEach { view.addSubview($0) }
        
        username.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(view).multipliedBy(0.9)
            make.centerX.equalTo(view)
        }
        
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom).offset(10)
            make.width.equalTo(username)
            make.centerX.equalTo(view)
        }
        
        password.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(10)
            make.width.equalTo(username)
            make.centerX.equalTo(view)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(10)
            make.width.equalTo(username)
            make.centerX.equalTo(view)
        }
        
        doSomethingButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(10)
            make.width.equalTo(username)
            make.centerX.equalTo(view)
        }
    }
    
}
