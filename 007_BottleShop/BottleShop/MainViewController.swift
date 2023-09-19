//
//  ViewController.swift
//  BottleShop
//
//  Created by do hee kim on 2023/08/08.
//

import UIKit
import Alamofire
import SnapKit

class MainViewController: UIViewController {
    
    var beers: [Beer] = []

    @IBOutlet var beerCollectionView: UICollectionView!
    
    let recommendView = {
        let view = RecommendBeerView()
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "beer warehouse"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "hand.thumbsup"), style: .plain, target: self, action: #selector(recommendButtonClicked))
        navigationController?.navigationBar.tintColor = .black
        
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        let nib = UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil)
        beerCollectionView.register(nib, forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
        
        beerCollectionViewLayout()
        
        configureView()
        setConstraints()
        
        Network.shared.request(type: [Beer].self, api: .beers(filterType: nil, value: nil)) { response in
            switch response {
            case .success(let success):
                self.beers = success
                DispatchQueue.main.async {
                    self.beerCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
    
    func configureView() {
        [recommendView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        recommendView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.horizontalEdges.equalTo(view).inset(20)
        }
    }

    @objc func recommendButtonClicked() {
        if recommendView.isHidden {
            Network.shared.request(type: [Beer].self, api: .randomBeer) { response in
                switch response {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.recommendView.isHidden = false
                        
                        guard let beer = success.first else {
                            print("맥주 정보 없음")
                            return
                        }
                        self.recommendView.setData(beer: beer)
                    }
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            }
        } else {
            self.recommendView.isHidden = true
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        vc.beerData = beers[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
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

