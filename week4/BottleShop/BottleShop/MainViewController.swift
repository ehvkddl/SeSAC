//
//  ViewController.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var beers: [Beer] = []

    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "beer warehouse"
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        let nib = UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil)
        beerCollectionView.register(nib, forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
        
        beerCollectionViewLayout()
        
        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.punkapi.com/v2/beers"

        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    self.beers = try decoder.decode([Beer].self, from: data)
                    
                    self.beerCollectionView.reloadData()
                } catch {
                    print(error.localizedDescription, "ㅠㅠ")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier, for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
        
        let row = beers[indexPath.row]
        
        cell.configureCell(row: row)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }
    
}

extension MainViewController {
    
    func beerCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.4)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        
        beerCollectionView.collectionViewLayout = layout
    }
    
}

