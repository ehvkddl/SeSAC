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
        
        var description: String {
            switch self {
            case .mode: return "집중 모드를 사용하여 기기를 사용자화하고 통화 및 알림 소리가 울리지 않도록 할 수 있습니다. 제어 센터에서 집중 모드를 켜고 끌 수 있습니다."
            case .share: return "집중 모드는 모든 기기에 걸쳐 공유되며, 이 기기에서 집중 모드를 켜면 다른 모든 기기에서도 그 집중 모드가 켜집니다."
            case .state: return "앱에 권한을 허용하면 해당 앱이 집중 모드 중에는 알림 소리가 울리지 않는다는 것을 공유할 수 있습니다."
            }
        }
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
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.footerMode = .supplementary
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
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionFooter) { supplementaryView, elementKind, indexPath in
            var contentConfiguration = UIListContentConfiguration.plainFooter()
            contentConfiguration.text = Section.allCases[indexPath.section].description
            contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .footnote)
            supplementaryView.contentConfiguration = contentConfiguration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })

        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(modeList, toSection: .mode)
        snapshot.appendItems(shareList, toSection: .share)
        snapshot.appendItems(stateList, toSection: .state)
        dataSource.apply(snapshot)
    }
    
}
