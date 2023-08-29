//
//  TestCollectionViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/29.
//

import UIKit

class TestCollectionViewCell: BaseCollectionViewCell {
    
    let contentsView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        return view
    }()
    
    let releaseDateLabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let genreLabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let mediaTypeImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    let backdropImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let voteTextLabel = {
        let lbl = PaddingLabel()
        lbl.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        lbl.text = "평점"
        lbl.textColor = .white
        lbl.backgroundColor = #colorLiteral(red: 0.3468087614, green: 0.3369399607, blue: 0.8411970139, alpha: 1)
        return lbl
    }()
    
    let voteAverageLabel = {
        let lbl = PaddingLabel()
        lbl.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        lbl.backgroundColor = .white
        return lbl
    }()
    
    let titleLabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return lbl
    }()
    
    let originalTitleLabel = {
        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize: 17)
        return lbl
    }()
    
    let overviewLabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let dividerView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let moreDetailButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled() // apple system button
        config.title = "자세히 보기"
        config.image = UIImage(systemName: "chevron.right")
        
        config.buttonSize = .mini
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .clear
        
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        config.imagePadding = UIScreen.main.bounds.width * 0.58
        config.imagePlacement = .trailing
        
        config.cornerStyle = .capsule
        
        btn.configuration = config
        
        return btn
    }()
    
    var delegate: PassTrendInfoDelegate?
    var index: Int?
    
    @objc func moreDetailButtonClicked() {
        guard let idx = index else { return }
        delegate?.moreDetailButtonClicked(index: idx)
    }
    
    func setData(row: VideoInfo) {
        releaseDateLabel.text = row.releaseDate
        
        let genreTexts = row.genreIDS.map { GenreManager.shared.convertText(with: $0) }
        genreLabel.text = genreTexts.map { "#\($0)" }.joined(separator: " ")
        
        let image = row.mediaType == .movie ? UIImage(systemName: "popcorn") : UIImage(systemName: "tv")
        mediaTypeImageView.image = image
        
        if let backdrop = row.backdropPath {
            let path = URL(string: URL.imageURL + backdrop)
            backdropImageView.kf.setImage(with: path)
        }
        
        voteAverageLabel.text = String(row.voteAverage)

        titleLabel.text = row.title != nil ? row.title : row.name
//        originalTitleLabel.text = row.originalTitle != nil ? "(\(row.originalTitle!))" : ""
        overviewLabel.text = row.overview
    }
    
    override func configureView() {
        [contentsView, releaseDateLabel, genreLabel, mediaTypeImageView, backdropImageView, voteTextLabel, voteAverageLabel, titleLabel, originalTitleLabel, overviewLabel, dividerView, moreDetailButton].forEach { addSubview($0) }
        
        moreDetailButton.addTarget(self, action: #selector(moreDetailButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(15)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.leading.equalTo(releaseDateLabel)
        }
        
        mediaTypeImageView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.top)
            make.bottom.equalTo(genreLabel.snp.bottom)
            make.leading.equalTo(genreLabel.snp.trailing).offset(10)
            make.trailing.equalTo(releaseDateLabel.snp.trailing)
            make.size.equalTo(30)
        }
        
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(7)
            make.horizontalEdges.equalTo(releaseDateLabel)
            make.bottom.equalToSuperview().inset(16)
        }

        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentsView)
            make.width.equalTo(backdropImageView.snp.height).multipliedBy(1.778)
        }
        
        voteTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(backdropImageView).inset(18)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.leading.equalTo(voteTextLabel.snp.trailing)
            make.bottom.equalTo(voteTextLabel.snp.bottom)
        }
        
//        titleLabel.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
//        titleLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(dividerView)
            make.height.equalTo(22)
        }
        
//        originalTitleLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(titleLabel)
//            make.leading.equalTo(titleLabel.snp.trailing).offset(1)
//            make.trailing.equalTo(dividerView.snp.trailing)
//            make.height.equalTo(22)
//        }
        
        overviewLabel.setContentHuggingPriority(.init(rawValue: 750), for: .vertical)
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(dividerView)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentsView).inset(18)
            make.height.equalTo(1)
        }
        
        moreDetailButton.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentsView).inset(18)
            make.height.equalTo(25)
            make.bottom.equalTo(contentsView.snp.bottom).inset(10)
        }
        
    }
    
}
