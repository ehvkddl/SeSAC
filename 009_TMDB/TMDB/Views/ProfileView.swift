//
//  ProfileView.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/30.
//

import UIKit

class ProfileView: BaseView {
    
    let tableView = {
        let view = UITableView()
        
        view.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.identifier)
        view.register(ProfileContentTableViewCell.self, forCellReuseIdentifier: ProfileContentTableViewCell.identifier)
        
        view.rowHeight = UITableView.automaticDimension
        
        return view
    }()
    
    override func configureView() {
        [tableView].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
