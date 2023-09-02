//
//  Example3ViewController.swift
//  CodeBase
//
//  Created by do hee kim on 2023/08/22.
//

import UIKit
import SnapKit

class Example3ViewController: UIViewController {

    let closeButton = {
        let btn = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        btn.setImage(image, for: .normal)
        
        btn.tintColor = .white
        
        return btn
    }()
    
    let dateLabel = {
        let lbl = UILabel()
        
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        return lbl
    }()
    
    let locationButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = "서울, 신림동"
        config.image = UIImage(systemName: "location.fill")
        
        config.baseForegroundColor = .white
        config.buttonSize = .medium
        config.imagePadding = 20
        config.imagePlacement = .leading
        config.titleAlignment = .leading
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20)
            
            return outgoing
        }
        
        btn.configuration = config
        
        return btn
    }()
    
    let shareButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .white
        
        return btn
    }()
    
    let reloadButton = {
        let btn = UIButton()
        
        btn.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        btn.tintColor = .white
        
        return btn
    }()
    
    let temperatureLabel = {
        let lbl = PaddingLabel()
        
        lbl.text = "지금은 9℃ 에요"
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 7
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    let humidityLabel = {
        let lbl = PaddingLabel()
        
        lbl.text = "78% 만큼 습해요"
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 7
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 190/255, green: 206/255, blue: 222/255, alpha: 1)
        
        configureUI()
        setData()
    }
    
    func getDateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"

        let dateString = dateFormatter.string(from: Date())
        
        return dateString
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
    
}

extension Example3ViewController {
    
    func configureUI() {
        [closeButton, dateLabel, locationButton, shareButton, reloadButton, temperatureLabel, humidityLabel].forEach { view.addSubview($0) }
        
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.trailing.equalTo(view).inset(26)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(26)
        }
        
        locationButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.equalTo(view).inset(8)
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton)
            make.trailing.equalTo(reloadButton.snp.leading).offset(-26)
            make.size.equalTo(20)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton)
            make.trailing.equalTo(view).inset(16)
            make.size.equalTo(20)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(locationButton.snp.bottom).offset(16)
            make.leading.equalTo(view).inset(16)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(12)
            make.leading.equalTo(temperatureLabel.snp.leading)
        }
    }
    
    func setData() {
        dateLabel.text = getDateAsString()
    }
    
}
