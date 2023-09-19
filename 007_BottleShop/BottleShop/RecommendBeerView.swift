//
//  RecommendBeerView.swift
//  BottleShop
//
//  Created by do hee kim on 2023/09/20.
//

import UIKit
import SnapKit

class RecommendBeerView: UIView {

    let titleLabel = {
        let lbl = UILabel()
        lbl.text = "Beer Recommendation!"
        lbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    let imageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nameLabel = {
        let lbl = UILabel()
        lbl.text = "beeeeeeeeeeeeeeeeeeeeer"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    let taglineLabel = {
        let lbl = UILabel()
        lbl.text = "so delicious beer"
        lbl.font = UIFont.italicSystemFont(ofSize: 14)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.layer.cornerRadius = 10
        
        [titleLabel, imageView, nameLabel, taglineLabel].forEach { addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(20)
            make.horizontalEdges.equalTo(self).inset(16)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.centerX.equalTo(self)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(taglineLabel.snp.top).offset(-3)
            make.horizontalEdges.equalTo(titleLabel).inset(8)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).inset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
    }
    
    func setData(beer: Beer) {
        let url = URL(string: beer.imageURL)
        imageView.kf.setImage(with: url)
        
        nameLabel.text = beer.name
        
        taglineLabel.text = beer.tagline
    }
    
}
