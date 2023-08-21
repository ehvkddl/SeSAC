//
//  TrendCollectionViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/12.
//

import UIKit
import Kingfisher

protocol ButtonTappedDelegate: AnyObject {
    func cellButtonTapped(index: Int)
}

class TrendCollectionViewCell: UICollectionViewCell {

    @IBOutlet var contentsView: UIView!
    
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var mediaTypeImageView: UIImageView!
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var voteTextLabel: PaddingLabel!
    @IBOutlet var voteAverageLabel: PaddingLabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var originalTitleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var moreDetailButton: UIButton!
    
    weak var delegate: ButtonTappedDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func moreDetailButtonClicked(_ sender: UIButton) {
        guard let idx = index else { return }
        delegate?.cellButtonTapped(index: idx)
    }
    
    func configureCell(row: VideoInfo) {
        configureImage()
        configureVoteLabel()
        configureButton()
        configureShadow()
        
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
        originalTitleLabel.text = row.originalTitle != nil ? "(\(row.originalTitle!))" : ""
        overviewLabel.text = row.overview
    }
    
    func configureImage() {
        backdropImageView.contentMode = .scaleAspectFill
        
        backdropImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backdropImageView.layer.cornerRadius = 10
    }
    
    func configureVoteLabel() {
        voteTextLabel.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        voteAverageLabel.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    func configureButton() {
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
        
        moreDetailButton.configuration = config
    }
    
    func configureShadow() {
        contentsView.layer.cornerRadius = 10
        
        contentsView.layer.shadowColor = UIColor.black.cgColor
        contentsView.layer.shadowOpacity = 0.3
        contentsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentsView.layer.shadowRadius = 10
    }
    
}
