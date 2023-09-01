//
//  ProfileEditViewController.swift
//  TMDB
//
//  Created by do hee kim on 2023/09/01.
//

import UIKit

class ProfileEditViewController: BaseViewController {

    var type: Profile.Content?
    var content: String?
    
    var dataSendClosure: ((Profile.Content, String) -> Void)?
    
    let mainView = ProfileEditView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        guard let type = self.type else { return }
        
        title = type.rawValue
        mainView.typeLabel.text = type.rawValue
        mainView.editTextField.text = content
        
        configureNavigationBar()
    }

}

extension ProfileEditViewController {
    
    func configureNavigationBar() {
        let img = UIImage(systemName: "chevron.backward", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .lightGray
        navigationBarAppearance.backgroundColor = .clear
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    @objc
    func cancelButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func doneButtonClicked() {
        guard let type = type else { return }
        guard let text = mainView.editTextField.text else { return }
        
        self.dataSendClosure?(type, text)
        
        navigationController?.popViewController(animated: true)
    }
    
}
