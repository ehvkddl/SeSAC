//
//  ViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/11.
//

import UIKit

protocol PassTrendInfoDelegate {
    func moreDetailButtonClicked(index: Int)
}

class TrendViewController: BaseViewController {

    let mainView = TrendView()
    
    var trends: [VideoInfo] = []
    var genreDict: [Int: String] = [:]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TmdbAPIManager.shared.fetchGenres { genres in
            let _ = genres.map { GenreManager.shared.updateGenreDict(id: $0.id, name: $0.name) }
            
            TmdbAPIManager.shared.fetchTrend { trend in
                self.trends = trend.results
                
                self.mainView.trendCollectionView.reloadData()
            }
        }
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.trendCollectionView.delegate = self
        mainView.trendCollectionView.dataSource = self
        
        configureNavigationBar()
    }

}

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }

        cell.setData(row: trends[indexPath.row])
        
        cell.delegate = self
        cell.index = indexPath.row

        return cell
    }

}

extension TrendViewController {
    
    @objc
    func listButtonTapped() {
        print("list")
    }
    
    @objc
    func magnifyingButtonTapped() {
        let vc = ProfileViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}

extension TrendViewController {
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(magnifyingButtonTapped))
        
        self.navigationController?.navigationBar.tintColor = .black
    }
    
}

extension TrendViewController: PassTrendInfoDelegate {
    
    func moreDetailButtonClicked(index: Int) {
        // storyboard
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        vc.content = trends[index]
        vc.type = trends[index].mediaType
        vc.id = trends[index].id
        
        navigationController?.pushViewController(vc, animated: true)
        
        // code
        // let vc = DetailViewController()
        // navigationController?.pushViewController(vc, animated: true)
    }
    
}
