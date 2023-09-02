//
//  PhotoViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit

class PhotoViewController: BaseViewController {

    let mainView = PhotoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func photoChangeButtonClicked() {
        let alert = UIAlertController(title: "사진 가져올 방법을 선택해주세요", message: nil, preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default)
        let webSearch = UIAlertAction(title: "웹에서 검색하기", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(gallery)
        alert.addAction(webSearch)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    override func configureView() {
        super.configureView()
        
        mainView.photoChangeButton.addTarget(self, action: #selector(photoChangeButtonClicked), for: .touchUpInside)
    }
}
