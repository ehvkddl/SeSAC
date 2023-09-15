//
//  MainDiaryViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/15.
//

import UIKit

struct User {
    var name: String
    var age: Int
}

class MainDiaryViewController: BaseViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        registCell()
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

extension MainDiaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: "nil")
        return cell
    }
    
    func registCell() {
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.image = UIImage(systemName: "book.closed")
            content.text = "일기 제목"
            content.secondaryText = "0000.00.00"
            cell.contentConfiguration = content
        }
    }
    
    func layout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
