//
//  LoginViewController.swift
//  Otdo
//
//  Created by do hee kim on 2023/11/21.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let emailTextField = ODTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = ODTextField(placeholderText: "비밀번호를 입력해주세요")
    
    let loginButton = {
        let btn = UIButton()
        btn.backgroundColor = Constants.Color.accent
        btn.setTitle("로그인", for: .normal)
        btn.layer.cornerRadius = Constants.cornerRadius
        return btn
    }()
    
    let loginStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let signUpText = {
        let lbl = UILabel()
        lbl.text = "아직 회원이 아니신가요?"
        return lbl
    }()
    
    let signUpButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        return btn
    }()
    
    let signUpStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }

    private func bind() {
        signUpButton.rx.tap
            .subscribe(with: self) { owner, value in
                let vc = SignUpViewController()
                vc.modalPresentationStyle = .fullScreen
                owner.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        
        [emailTextField, passwordTextField, loginButton].forEach { loginStackView.addArrangedSubview($0) }
        [signUpText, signUpButton].forEach { signUpStackView.addArrangedSubview($0) }
        [loginStackView, signUpStackView].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(emailTextField)
            make.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(emailTextField)
            make.height.equalTo(50)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalTo(view)
        }
    }
    
}
