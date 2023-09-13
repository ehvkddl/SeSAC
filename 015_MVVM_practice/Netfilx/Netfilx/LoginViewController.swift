//
//  ViewController.swift
//  Netfilx
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var loginvm = LoginViewModel()

    let titleLabel = {
        let lbl = UILabel()
        lbl.text = "CHAPFLIX"
        lbl.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        lbl.textColor = .red
        return lbl
    }()
    
    let stackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 15
        return view
    }()
    
    let idTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "이메일 주소 또는 전화번호")
        return tf
    }()
    
    let pwTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "비밀번호")
        return tf
    }()
    
    let loginButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        
        loginvm.id.bind { [self] _ in
            loginvm.checkValidity()
        }
        
        loginvm.pw.bind { [self] _ in
            loginvm.checkValidity()
        }
        
        loginvm.isValid.bind { [self] bool in
            loginButton.backgroundColor = bool ? .white : .lightGray
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        [idTextField, pwTextField, loginButton].forEach { stackView.addArrangedSubview($0) }
        [titleLabel, stackView].forEach { view.addSubview($0) }
        
        idTextField.addTarget(self, action: #selector(idTextFieldChange), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChange), for: .editingChanged)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        [idTextField, pwTextField].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(35)
                make.horizontalEdges.equalToSuperview()
            }
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.horizontalEdges.equalToSuperview()
        }
    }

}

extension LoginViewController {
    
    @objc func idTextFieldChange() {
        guard let text = idTextField.text else { return }
        loginvm.id.value = text
    }
    
    @objc func pwTextFieldChange() {
        guard let text = pwTextField.text else { return }
        loginvm.pw.value = text
    }
    
}
