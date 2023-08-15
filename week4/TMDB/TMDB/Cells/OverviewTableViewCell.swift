//
//  OverviewTableViewCell.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/16.
//

import UIKit

protocol moreOverviewButtonTappedDelegate: AnyObject {
    func buttonTapped(index: IndexPath)
}

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var overviewButton: UIButton!
    
    weak var delegate: moreOverviewButtonTappedDelegate?
    var indexPath: IndexPath?
    
    var isDetailed: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func moreOverviewButtonTapped(_ sender: UIButton) {
        isDetailed.toggle()
        
        if isDetailed {
            overviewLabel.numberOfLines = 0
            overviewButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            overviewLabel.numberOfLines = 2
            overviewButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        
        guard let idxPath = indexPath else { return }
        delegate?.buttonTapped(index: idxPath)
    }
    
    func configureCell(overview: String) {
        overviewLabel.numberOfLines = 2
        overviewLabel.text = overview
    }
    
}
