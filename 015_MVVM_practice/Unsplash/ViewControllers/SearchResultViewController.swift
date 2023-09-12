//
//  SearchResultController.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class SearchResultViewController: BaseViewController {
    
    lazy var photoCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: photoCollectionViewLayout())
        view.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        [photoCollectionView].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        photoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func photoCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 1
        let width = UIScreen.main.bounds.width - (spacing * 2)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
}
