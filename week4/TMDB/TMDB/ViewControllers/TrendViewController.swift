//
//  ViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/11.
//

import UIKit

class TrendViewController: UIViewController {

    @IBOutlet var trendCollectionView: UICollectionView!
    
    var trends: [Trend] = []
    var genreDict: [Int: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        TmdbAPIManager.shared.fetchTrend(completionHandler: { trend in
            self.trends = trend.results
            
            TmdbAPIManager.shared.fetchGenres { genres in
                let _ = genres.map { self.genreDict[$0.id] = $0.name }
                self.setGenresTexts()
            }
            
            self.trendCollectionView.reloadData()
        })
    }
    
    func convertGenresText(of ids: [Int]) -> [String] {
        var texts: [String] = []
        
        let _ = ids.map {
            guard let text = genreDict[$0] else { return }
            texts.append(text)
        }
        
        return texts
    }
    
    func setGenresTexts() {
        for i in 0..<trends.count {
            trends[i].genreTexts = convertGenresText(of: trends[i].genreIDS)
        }
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }

        cell.delegate = self
        cell.index = indexPath.row
        cell.configureCell(row: trends[indexPath.row])
        
        return cell
    }
    
}

extension TrendViewController: ButtonTappedDelegate {
    func cellButtonTapped(index: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: DetailTrendViewController.identifier) as? DetailTrendViewController else { return }
        vc.content = trends[index]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendViewController {
    
    @objc
    func listButtonTapped() {
        print("list")
    }
    
    @objc
    func magnifyingButtonTapped() {
        print("magnifying")
    }
    
}

extension TrendViewController {
    
    func configureView() {
        configureCollectionView()
        configureNavigationBar()
    }
    
    func configureCollectionView() {
        trendCollectionView.delegate = self
        trendCollectionView.dataSource = self
        
        let nib = UINib(nibName: TrendCollectionViewCell.identifier, bundle: nil)
        trendCollectionView.register(nib, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        
        trendCollectionViewLayout()
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(magnifyingButtonTapped))
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func trendCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.12)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
        layout.minimumLineSpacing = spacing
        
        trendCollectionView.collectionViewLayout = layout
    }
    
}
