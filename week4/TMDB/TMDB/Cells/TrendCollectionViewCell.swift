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
    @IBOutlet var mediaTypeLabel: UILabel!
    
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var voteTextLabel: PaddingLabel!
    @IBOutlet var voteAverageLabel: PaddingLabel!
    
    @IBOutlet var titleLabel: UILabel!
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
    
    func configureCell(row: Trend) {
        configureImage()
        configureVoteLabel()
        configureButton()
        configureShadow()
        
        releaseDateLabel.text = row.releaseDate
        
        guard let genres = row.genreTexts else { return }
        genreLabel.text = genres.map { "#\($0)" }.joined(separator: " ")
        
        mediaTypeLabel.text = row.mediaType.rawValue
        
        let url = URL(string: URL.imageURL + row.backdropPath)
        backdropImageView.kf.setImage(with: url)
        
        voteAverageLabel.text = String(row.voteAverage)
        
        titleLabel.text = row.title != nil ? row.title : row.name
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
