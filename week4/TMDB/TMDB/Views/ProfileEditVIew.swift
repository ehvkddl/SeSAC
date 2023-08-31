//
//  ProfileEditVIew.swift
//  TMDB
//
//  Created by do hee kim on 2023/09/01.
//

import UIKit

class ProfileEditView: BaseView {
    
    lazy var typeLabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return lbl
    }()
    
    let editTextField = {
        let tf = UITextField()
        return tf
    }()
    
    let divider = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func configureView() {
        print("ProfileEditView configureView")
        [typeLabel, editTextField, divider].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalTo(self).inset(16)
        }
        
        editTextField.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(typeLabel)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(editTextField.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.3)
        }
    }
    
}
