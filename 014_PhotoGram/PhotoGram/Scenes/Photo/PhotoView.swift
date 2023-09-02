//
//  PhotoView.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit

class PhotoView: BaseView {
    
    let photoImage = {
        let img = UIImageView()
        img.image = UIImage(systemName: "photo")
        img.tintColor = .gray
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let photoChangeButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.title = "사진 가져오기"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.titleAlignment = .center
        config.contentInsets = .init(top: 14, leading: 10, bottom: 14, trailing: 10)
        btn.configuration = config
        
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    override func configureView() {
        [photoImage, photoChangeButton].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        photoChangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(40)
        }
    }
    
}
