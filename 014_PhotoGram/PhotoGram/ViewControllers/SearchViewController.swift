//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit

class SearchViewController: BaseViewController {
    
    var photos: [PhotoResult] = []
    
    var imageSendClosure: ((String) -> Void)?
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.placeholder = "어떤 사진을 찾고 싶으신가요?"
        view.becomeFirstResponder()
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        
        view.delegate = self
        
        return view
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section, PhotoResult>!
    
    enum Section: Int, CaseIterable {
        case photo = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCell()
    }
    
    override func configureView() {
        [searchBar, collectionView].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let serchWord = searchBar.text, serchWord != "" else { return }
        UnsplashAPIManager.shared.fetchPhotos(of: serchWord) { photos in
            self.photos = photos
            
            DispatchQueue.main.async {
                print(self.photos)
                
                var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoResult>()
                snapshot.appendSections(Section.allCases)
                snapshot.appendItems(photos, toSection: .photo)
                self.dataSource.apply(snapshot)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thumbUrl = photos[indexPath.item].urls.thumb
        
        self.imageSendClosure?(thumbUrl)
        
        dismiss(animated: true)
    }
    
}

extension SearchViewController {
    
    func configureCell() {
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, PhotoResult> { cell, indexPath, itemIdentifier in
            cell.imageView.load(from: itemIdentifier.urls.thumb)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func layout() -> UICollectionViewLayout {
        let spacing: CGFloat = 1
        let width = UIScreen.main.bounds.width
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth((1 - (spacing * 2) / width) / 3),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 1
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
