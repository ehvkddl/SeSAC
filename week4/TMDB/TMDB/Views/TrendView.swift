//
//  TrendView.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
    
    lazy var trendCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: trendCollectionViewLayout())
        view.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        view.collectionViewLayout = trendCollectionViewLayout()
        return view
    }()
    
    override func configureView() {
        [trendCollectionView].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        trendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func trendCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width * 1.12)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: spacing, right: 0)
        layout.minimumLineSpacing = spacing
        
        return layout
    }
    
}
