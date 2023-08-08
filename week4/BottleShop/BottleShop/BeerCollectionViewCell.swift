//
//  BeerCollectionViewCell.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BeerCollectionViewCell"

    @IBOutlet var beerImageView: UIImageView!
    
    @IBOutlet var beerNameLabel: UILabel!
    
    @IBOutlet var beerTaglineLabel: UILabel!
    
    @IBOutlet var beerSrmImageView: UIImageView!
    @IBOutlet var beerInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(row: Beer) {
        
    }
    
}
