//
//  ProfileImageTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/30.
//

import UIKit

class ProfileImageTableViewCell: BaseTableViewCell {
    
    lazy var image = {
        let img = UIImageView()
        img.image = UIImage(named: "chap")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let editButton = {
        let btn = UIButton()
        btn.setTitle("사진 수정", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return btn
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        image.layer.cornerRadius = image.frame.width / 2
    }
    
    override func configureView() {
        [image, editButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(18)
        }
    }
    
}
