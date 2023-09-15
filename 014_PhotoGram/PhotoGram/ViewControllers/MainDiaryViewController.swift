//
//  MainDiaryViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/15.
//

import UIKit
import RealmSwift

struct User {
    var name: String
    var age: Int
}

class MainDiaryViewController: BaseViewController {
    
    let repository = DiaryRepository()
    
    var diary: Results<Diary>!
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var dataSource: UICollectionViewDiffableDataSource<Section, Diary>!
    
    enum Section: Int, CaseIterable {
        case all = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diary = repository.fetch()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Diary>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(diary.map { $0 }, toSection: .all)
        
        configureCell()
        
        dataSource.apply(snapshot)
    }
    
    override func configureView() {
        super.configureView()
        
        [collectionView].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension MainDiaryViewController {
    
    func configureCell() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Diary> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.image = UIImage(systemName: "book.closed")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.date)"
            content.textToSecondaryTextVerticalPadding = 5
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
