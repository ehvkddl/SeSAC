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
        view.spacing = 25
        return view
    }()
    
    let idTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "이메일 주소 또는 전화번호")
        return tf
    }()
    
    let idValidImage = {
        let img = ValidityImageView(frame: .zero)
        return img
    }()
    
    let idLabel = {
        let lbl = ConditionLabel()
        lbl.text = "이메일 또는 전화번호 형식이 맞지 않습니다."
        return lbl
    }()
    
    let pwTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "비밀번호")
        return tf
    }()
    
    let pwValidImage = {
        let img = ValidityImageView(frame: .zero)
        return img
    }()
    
    let pwLabel = {
        let lbl = ConditionLabel()
        lbl.text = "비밀번호는 영어, 숫자, 특수문자가 포함된 8~50자리입니다."
        return lbl
    }()
    
    let nicknameTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "닉네임")
        return tf
    }()
    
    let nicknameValidImage = {
        let img = ValidityImageView(frame: .zero)
        return img
    }()
    
    let nicknameLabel = {
        let lbl = ConditionLabel()
        lbl.text = "닉네임은 2글자 이상 8글자 이하여야 합니다."
        return lbl
    }()
    
    let locationTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "위치(Optional)")
        return tf
    }()
    
    let recommendCodeTextField = {
        let tf = LoginTextField()
        tf.setupView(placeholder: "추천 코드 입력")
        return tf
    }()
    
    let recommendCodeValidImage = {
        let img = ValidityImageView(frame: .zero)
        return img
    }()
    
    let recommendCodeLabel = {
        let lbl = ConditionLabel()
        lbl.text = "추천 코드는 6자리 입니다."
        return lbl
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
        
        loginvm.id.bind { [self] id in
            loginvm.checkValidity()
            
            idValidImage.isHidden = id.isEmpty ? true : false
            
            let idIsValid = loginvm.checkIDValidity()
            idIsValid ? idValidImage.setValid() : idValidImage.setInvalid()
            idLabel.isHidden = id.isEmpty ? true : idIsValid ? true : false
        }
        
        loginvm.pw.bind { [self] pw in
            loginvm.checkValidity()
            
            pwValidImage.isHidden = pw.isEmpty ? true : false
            
            let pwIsValid = loginvm.checkPWValidity()
            pwIsValid ? pwValidImage.setValid() : pwValidImage.setInvalid()
            pwLabel.isHidden = pw.isEmpty ? true : pwIsValid ? true : false
        }
        
        loginvm.nickname.bind { [self] nickname in
            loginvm.checkValidity()
            
            nicknameValidImage.isHidden = nickname.isEmpty ? true : false
            
            let nicknameIsValid = loginvm.checkNicknameValidity()
            nicknameIsValid ? nicknameValidImage.setValid() : nicknameValidImage.setInvalid()
            nicknameLabel.isHidden = nickname.isEmpty ? true : nicknameIsValid ? true : false
        }
        
        loginvm.recommendCode.bind { [self] recommendCode in
            loginvm.checkValidity()
            
            recommendCodeValidImage.isHidden = recommendCode.isEmpty ? true : false
            
            let recommendCodeIsValid = loginvm.checkRecommendCodeValidity()
            recommendCodeIsValid ? recommendCodeValidImage.setValid() : recommendCodeValidImage.setInvalid()
            recommendCodeLabel.isHidden = recommendCode.isEmpty ? true : recommendCodeIsValid ? true : false
        }
        
        loginvm.isValid.bind { [self] bool in
            loginButton.backgroundColor = bool ? .white : .lightGray
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        [idTextField, pwTextField, nicknameTextField, locationTextField, recommendCodeTextField, loginButton].forEach { stackView.addArrangedSubview($0) }
        [titleLabel, stackView, idValidImage, idLabel, pwValidImage, pwLabel, nicknameValidImage, nicknameLabel, recommendCodeValidImage, recommendCodeLabel].forEach { view.addSubview($0) }
        
        idTextField.addTarget(self, action: #selector(idTextFieldChange), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFieldChange), for: .editingChanged)
        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldChange), for: .editingChanged)
        locationTextField.addTarget(self, action: #selector(locationTextFieldChange), for: .editingChanged)
        recommendCodeTextField.addTarget(self, action: #selector(recommendCodeTextFieldChange), for: .editingChanged)
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
        
        [idTextField, pwTextField, nicknameTextField, locationTextField, recommendCodeTextField].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(35)
                make.horizontalEdges.equalToSuperview()
            }
        }
        
        idValidImage.snp.makeConstraints { make in
            make.centerY.equalTo(idTextField)
            make.trailing.equalTo(idTextField.snp.trailing).inset(10)
            make.size.equalTo(20)
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(idTextField.snp.horizontalEdges).inset(3)
        }
        
        pwValidImage.snp.makeConstraints { make in
            make.centerY.equalTo(pwTextField)
            make.trailing.equalTo(pwTextField.snp.trailing).inset(10)
            make.size.equalTo(20)
        }
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(pwTextField.snp.horizontalEdges).inset(3)
        }
        
        nicknameValidImage.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameTextField)
            make.trailing.equalTo(nicknameTextField.snp.trailing).inset(10)
            make.size.equalTo(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(nicknameTextField.snp.horizontalEdges).inset(3)
        }
        
        recommendCodeValidImage.snp.makeConstraints { make in
            make.centerY.equalTo(recommendCodeTextField)
            make.trailing.equalTo(recommendCodeTextField.snp.trailing).inset(10)
            make.size.equalTo(20)
        }
        
        recommendCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(recommendCodeTextField.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(recommendCodeTextField.snp.horizontalEdges).inset(3)
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
    
    @objc func nicknameTextFieldChange() {
        guard let text = nicknameTextField.text else { return }
        loginvm.nickname.value = text
    }
    
    @objc func locationTextFieldChange() {
        guard let text = nicknameTextField.text else { return }
        loginvm.location.value = text
    }
    
    @objc func recommendCodeTextFieldChange() {
        guard let text = recommendCodeTextField.text else { return }
        loginvm.recommendCode.value = text
    }
    
}
