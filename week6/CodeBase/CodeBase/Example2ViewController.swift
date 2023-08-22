//
//  Example2ViewController.swift
//  CodeBase
//
//  Created by do hee kim on 2023/08/22.
//

import UIKit
import SnapKit

class Example2ViewController: UIViewController {
    
    let backgroundImage = {
        let img = UIImageView()
        
        img.image = UIImage(named: "chapssal2")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    let closeButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()

    let settingButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
        let image = UIImage(systemName: "gearshape.circle", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()
    
    let wonButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
        let image = UIImage(systemName: "creditcard.circle", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()
    
    let giftButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .thin)
        let image = UIImage(systemName: "gift.circle", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()
    
    // MARK: - profile
    let profileImage = {
        let img = UIImageView()
        
        img.image = UIImage(named: "chapssal")
        img.layer.cornerRadius = 35
        img.layer.cornerCurve = .continuous
        img.clipsToBounds = true
        
        return img
    }()
    
    let nameLabel = {
        let lbl = UILabel()
        
        lbl.text = "Chap"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        return lbl
    }()
    
    let stateMessageLabel = {
        let lbl = UILabel()
        
        lbl.text = "code base로 UI를 잡아보는 중! 🥸"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 15)
        
        return lbl
    }()
    
    // MARK: - Divider
    let divider = {
        let view = UIView()
        
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let chatButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "나와의 채팅"
        config.image = UIImage(systemName: "bubble.left.fill")
        
        config.baseForegroundColor = .white
        config.buttonSize = .mini
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        
        btn.configuration = config
        
        return btn
    }()
    
    let profileEditButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "프로필 편집"
        config.image = UIImage(systemName: "pencil")
        
        config.baseForegroundColor = .white
        config.buttonSize = .mini
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        
        btn.configuration = config
        
        return btn
    }()
    
    let storyButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "카카오스토리"
        config.image = UIImage(systemName: "book.closed.fill")
        
        config.baseForegroundColor = .white
        config.buttonSize = .mini
        config.imagePadding = 10
        config.imagePlacement = .top
        config.titleAlignment = .center
        
        btn.configuration = config
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

}

extension Example2ViewController {
    
    func configureUI() {
        [backgroundImage, closeButton, settingButton, wonButton, giftButton, profileImage, nameLabel, stateMessageLabel, divider, chatButton, profileEditButton, storyButton].forEach { view.addSubview($0) }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view).inset(16)
        }
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalTo(view).inset(16)
        }
        
        wonButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalTo(settingButton.snp.leading).offset(-5)
        }
        
        giftButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalTo(wonButton.snp.leading).offset(-5)
        }

        // MARK: - profile
        profileImage.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(nameLabel.snp.top).offset(-7)
            make.size.equalTo(90)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(70)
            make.bottom.equalTo(stateMessageLabel.snp.top).offset(-7)
        }
        
        stateMessageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(70)
            make.bottom.equalTo(divider.snp.top).offset(-25)
        }
        
        // MARK: - Divider
        divider.snp.makeConstraints { make in
            make.bottom.equalTo(profileEditButton.snp.top).offset(-25)
            make.horizontalEdges.equalTo(view)
            make.height.equalTo(0.2)
        }
        
        chatButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileEditButton)
            make.trailing.equalTo(profileEditButton.snp.leading).offset(-8)
            
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        storyButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileEditButton)
            make.leading.equalTo(profileEditButton.snp.trailing).offset(8)
        }
    }
    
}
