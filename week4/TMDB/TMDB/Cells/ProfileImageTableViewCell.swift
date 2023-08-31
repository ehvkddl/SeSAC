//
//  ProfileImageTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/30.
//

import UIKit

class ProfileImageTableViewCell: BaseTableViewCell {
    
    let image = {
        let img = UIImageView()
        img.image = UIImage(named: "blankProfile")
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
    
    var delegate: ProfileImageEditButtonDelegate?
    
    @objc func ProfileImageEditButtonClicked() {
        delegate?.ProfileImageEditButtonClicked()
    }
    
    @objc
    func selectImageNotificationObserver(notification: NSNotification) {
        guard let img = notification.userInfo?["selectImage"] as? UIImage else { return }
        
        self.image.image = img
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        image.layer.cornerRadius = image.frame.width / 2
    }
    
    override func configureView() {
        [image, editButton].forEach { contentView.addSubview($0) }
        
        editButton.addTarget(self, action: #selector(ProfileImageEditButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
    }
    
    override func setConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(18)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).inset(18)
        }
    }
    
}
