//
//  Case2ViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/09/17.
//

import UIKit
import SnapKit

class Case2ViewController: ViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Setting, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setConstraints()
        configureDataSource()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        
        [collectionView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension Case2ViewController {
    
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            var contentConfiguration = UIListContentConfiguration.plainHeader()
            contentConfiguration.text = Setting.allCases[indexPath.section].text
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .headline)
            
            supplementaryView.contentConfiguration = contentConfiguration
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = Setting.allCases[indexPath.section].setting[indexPath.item]
            
            cell.contentConfiguration = contentConfiguration
        }
        
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Setting, String>()
        snapshot.appendSections(Setting.allCases)
        snapshot.appendItems(Setting.all.setting, toSection: .all)
        snapshot.appendItems(Setting.personal.setting, toSection: .personal)
        snapshot.appendItems(Setting.etc.setting, toSection: .etc)
        dataSource.apply(snapshot)
    }
    
}
