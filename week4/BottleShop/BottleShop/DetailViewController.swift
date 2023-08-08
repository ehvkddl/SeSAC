//
//  DetailViewController.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/09.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

    var beerData: Beer?
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerSrmImageView: UIImageView!
    
    @IBOutlet var beerNameLabel: UILabel!
    @IBOutlet var beerTaglineLabel: UILabel!
    
    @IBOutlet var beerDescriptionLabel: UILabel!
    
    @IBOutlet var beerInfoLabel: UILabel!
    
    @IBOutlet var beerFoodPairingLabel: UILabel!
    
    @IBOutlet var beerBrewersTipsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "🍺"
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        
        designView()
        configureView()
    }
    
    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailViewController {
    
    func configureView() {
        guard let beer = beerData else { return }
        
        let url = URL(string: beer.imageURL)!
        beerImageView.kf.setImage(with: url)
        beerSrmImageView.backgroundColor = UIColor.getBeerColor(srm: beer.srm ?? -1)
        
        beerNameLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
        
        beerInfoLabel.text = "\(beer.abv)% ALCOHOL BY VOLUME\(beer.ibu != nil ? " • \(beer.ibu!) IBU" : "")"
        
        beerDescriptionLabel.text = beer.description
        
        var pair = ""
        for i in 0..<beer.foodPairing.count {
            pair.append("\(beer.foodPairing[i])\n")
            if i < beer.foodPairing.count - 1 {
                pair.append("•\n")
            }
        }
        beerFoodPairingLabel.text = pair
        
        beerBrewersTipsLabel.text = beer.brewersTips
    }
    
    func designView() {
        beerNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        beerNameLabel.textAlignment = .center
        beerNameLabel.numberOfLines = 0
        
        beerTaglineLabel.font = UIFont.italicSystemFont(ofSize: 14)
        beerTaglineLabel.textAlignment = .center
        beerTaglineLabel.numberOfLines = 0
        
        beerInfoLabel.textAlignment = .center
        beerInfoLabel.textColor = .gray
        
        beerDescriptionLabel.numberOfLines = 0
        beerDescriptionLabel.textAlignment = .center
        
        beerFoodPairingLabel.numberOfLines = 0
        beerFoodPairingLabel.textAlignment = .center
        
        beerBrewersTipsLabel.numberOfLines = 0
        beerBrewersTipsLabel.textAlignment = .center
    }
}
