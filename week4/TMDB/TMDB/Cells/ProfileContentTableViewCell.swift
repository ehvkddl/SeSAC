//
//  ProfileContentTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/30.
//

import UIKit

class ProfileContentTableViewCell: BaseTableViewCell {
    
    let title = {
        let lbl = UILabel()
        lbl.text = "사용자 이름"
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return lbl
    }()
    
    let editTextField = {
        let tf = UITextField()
        tf.placeholder = "사용자 이름"
        return tf
    }()
    
    override func configureView() {
        [title, editTextField].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        title.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self).inset(12)
            make.leading.equalTo(self).inset(12)
            make.width.equalTo(self).multipliedBy(0.25)
        }
        
        editTextField.snp.makeConstraints { make in
            make.centerY.equalTo(title)
            make.leading.equalTo(title.snp.trailing).offset(3)
            make.trailing.equalTo(self).offset(5)
        }
    }
    
}
