//
//  BeerCollectionViewCell.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit
import Kingfisher

class BeerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BeerCollectionViewCell"

    @IBOutlet var beerImageView: UIImageView!
    
    @IBOutlet var beerNameLabel: UILabel!
    
    @IBOutlet var beerSrmImageView: UIImageView!
    @IBOutlet var beerInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }

    func configureCell(row: Beer) {
        let url = URL(string: row.imageURL)
        
        beerImageView.kf.setImage(with: url)
        
        beerNameLabel.text = row.name
        
        if let srm = row.srm {
            beerSrmImageView.backgroundColor = UIColor.getBeerColor(srm: srm)
        } else {
            beerSrmImageView.isHidden = true
        }
        
        guard let ibu = row.ibu else {
            beerInfoLabel.text = "\(row.abv)%"
            return
        }
        beerInfoLabel.text = "\(row.abv)% • \(ibu) IBU"
    }
    
    func designCell() {
        beerNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        beerNameLabel.textAlignment = .center
        
        beerInfoLabel.font = UIFont.systemFont(ofSize: 15)
        beerInfoLabel.textAlignment = .center
    }
    
}
