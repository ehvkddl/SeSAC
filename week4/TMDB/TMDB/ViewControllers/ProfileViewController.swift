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

protocol ProfileImageEditButtonDelegate {
    func ProfileImageEditButtonClicked()
}

import UIKit

class ProfileViewController: BaseViewController {
    
    var user = User(name: "Chapssal", nickname: "chap", introduce: "Hi, I'm a cute cat")

    let picker = UIImagePickerController()
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 취소 버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // 사진을 선택하거나 카메라 촬영 직후 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        NotificationCenter.default.post(name: .selectImage, object: nil, userInfo: ["selectImage": image])

        dismiss(animated: true)
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
            cell.delegate = self
            return cell
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileContentTableViewCell.identifier) as? ProfileContentTableViewCell else { return UITableViewCell() }
            
            let type = Profile.Content.allCases[indexPath.row]
            
            cell.type = type
            
            switch type {
            case .name: cell.editTextField.text = user.name
            case .nickname: cell.editTextField.text = user.nickname
            case .introduce: cell.editTextField.text = user.introduce
            }
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width * 0.25, bottom: 0, right: 0)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)

        let menu = Profile.allCases[indexPath.section]

        switch menu {
        case .image: break
        case .content:
            let vc = ProfileEditViewController()
            vc.type = Profile.Content.allCases[indexPath.row]
            
            vc.dataSendClosure = { type, data in
                
                switch type {
                case .name: self.user.name = data
                case .nickname: self.user.nickname = data
                case .introduce: self.user.introduce = data
                }
                
                tableView.reloadRows(at: [indexPath], with: .none)
            }

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ProfileViewController {
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        
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

extension ProfileViewController: ProfileImageEditButtonDelegate {
    
    func ProfileImageEditButtonClicked() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("갤러리 사용 불가, 사용자에게 토스트/얼럿")
            return
        }
        
        present(picker, animated: true)
    }
    
}
