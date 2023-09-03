//
//  PhotoViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit
import PhotosUI

class PhotoViewController: BaseViewController {

    let phpicker = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        return picker
    }()
    
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
        
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { [weak self] _ in
            self?.present(self!.phpicker, animated: true)
        }
        let webSearch = UIAlertAction(title: "웹에서 검색하기", style: .default) { [weak self] _ in
            let vc = SearchViewController()
            self?.present(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(gallery)
        alert.addAction(webSearch)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.photoChangeButton.addTarget(self, action: #selector(photoChangeButtonClicked), for: .touchUpInside)
        
        phpicker.delegate = self
    }
    
}

extension PhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self.mainView.photoImage.image = image
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
    
}
