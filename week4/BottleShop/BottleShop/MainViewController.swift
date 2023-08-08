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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
