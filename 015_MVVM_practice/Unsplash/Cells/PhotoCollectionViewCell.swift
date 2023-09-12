//
//  PhotoCollectionViewCell.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        view.tintColor = .gray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func configureView() {
        [imageView].forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
