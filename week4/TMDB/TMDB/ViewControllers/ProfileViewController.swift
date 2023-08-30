//
//  ProfileViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/08/30.
//

enum Profile: CaseIterable {
    case image
    case content
    
    var menu: [String] {
        switch self {
        case .image: return Image.allCases.map { $0.rawValue }
        case .content: return Content.allCases.map { $0.rawValue }
        }
    }
    
    enum Image: String, CaseIterable {
        case image = "프로필 사진"
    }
    
    enum Content: String, CaseIterable {
        case name = "이름"
        case nickname = "사용자 이름"
        case introduce = "소개"
    }
}

import UIKit

class ProfileViewController: BaseViewController {

    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func configureView() {
        super.configureView()
        
        title = "프로필 수정"
        
        configureNavigationBar()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Profile.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Profile.allCases[section].menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = Profile.allCases[indexPath.section]
        
        switch menu {
        case .image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTableViewCell.identifier) as? ProfileImageTableViewCell else { return UITableViewCell() }
            return cell
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileContentTableViewCell.identifier) as? ProfileContentTableViewCell else { return UITableViewCell() }
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width * 0.25, bottom: 0, right: 0)
            
            return cell
        }
    }
    
extension ProfileViewController {
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(cancelButtonClicked))
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc
    func doneButtonClicked() {
        print("완료")
    }
    
}
