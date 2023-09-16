//
//  Case1ViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/09/16.
//

import UIKit
import SnapKit

class Case1ViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case mode
        case share
        case state
    }
    
    enum SetType {
        case on
        case off
        case initial
    }
    
    struct Item: Hashable {
        let id = UUID().uuidString
        let image: UIImage?
        let imageColor: UIColor?
        let title: String
        let isSet: SetType?
    }
    
    let modeList = [
        Item(image: UIImage(systemName: "moon.fill"), imageColor: .systemIndigo, title: "방해금지 모드", isSet: .on),
        Item(image: UIImage(systemName: "bed.double.fill"), imageColor: .systemMint, title: "수면", isSet: .off),
        Item(image: UIImage(systemName: "person.fill"), imageColor: .systemPurple, title: "개인 시간", isSet: .initial),
        Item(image: UIImage(systemName: "lanyardcard.fill"), imageColor: .systemTeal, title: "업무", isSet: .initial)
    ]
    
    let shareList = [
        Item(image: nil, imageColor: nil, title: "모든 기기에서 공유", isSet: nil)
    ]
    
    let stateList = [
        Item(image: nil, imageColor: nil, title: "집중 모드 상태", isSet: .on)
    ]
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "집중 모드"
        
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

extension Case1ViewController {
    
    func createLayout() -> UICollectionViewLayout{
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, itemIdentifier in
            var contentConfiguration = UIListContentConfiguration.valueCell()
            contentConfiguration.image = itemIdentifier.image
            contentConfiguration.imageProperties.tintColor = itemIdentifier.imageColor
            contentConfiguration.text = itemIdentifier.title
            switch itemIdentifier.isSet {
            case .initial: contentConfiguration.secondaryText = "설정"
            case .on: contentConfiguration.secondaryText = "켬"
            default: break
            }
            cell.contentConfiguration = contentConfiguration
            
            switch indexPath.section {
            case 0, 2: cell.accessories = [.disclosureIndicator()]
            case 1: cell.accessories = [.customView(configuration: .init(customView: UISwitch(), placement: .trailing()))]
            default: break
            }
            
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(modeList, toSection: .mode)
        snapshot.appendItems(shareList, toSection: .share)
        snapshot.appendItems(stateList, toSection: .state)
        dataSource.apply(snapshot)
    }
    
}
