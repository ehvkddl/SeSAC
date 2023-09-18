//
//  PhotoViewController.swift
//  Unsplash
//
//  Created by do hee kim on 2023/09/13.
//

import UIKit

class PhotoViewController: BaseViewController {

    var vm = PhotoViewModel()
    
    lazy var searchController = {
        let view = UISearchController(searchResultsController: SearchResultViewController(vm: self.vm))
        view.searchBar.delegate = self
        return view
    }()
    
    let photoImageView = {
        let view = UIImageView()
        return view
    }()
    
    let refreshButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "arrow.clockwise")
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        btn.configuration = config
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        [photoImageView, refreshButton].forEach { view.addSubview($0) }
        
        refreshButton.addTarget(self, action: #selector(refreshButtonClicked), for: .touchUpInside)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    override func setNavigationBar() {
        navigationItem.title = "Unsplash"
        navigationItem.searchController = searchController
    }
    
    @objc func refreshButtonClicked() {
        print("refreshButtonClicked")
    }

}

extension PhotoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        vm.fetchPhoto(of: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vm.reset()
    }

}
