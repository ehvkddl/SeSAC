//
//  PhotoViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit
import PhotosUI

class PhotoViewController: BaseViewController {

    let photoImage = {
        let img = UIImageView()
        img.image = UIImage(systemName: "photo")
        img.tintColor = .gray
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let photoChangeButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.title = "사진 가져오기"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        config.titleAlignment = .center
        config.contentInsets = .init(top: 14, leading: 10, bottom: 14, trailing: 10)
        btn.configuration = config
        
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    let phpicker = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc
    func photoChangeButtonClicked() {
        let alert = UIAlertController(title: "사진 가져올 방법을 선택해주세요", message: nil, preferredStyle: .actionSheet)
        
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { [weak self] _ in
            self?.getPhotoFromGallery()
        }
        let webSearch = UIAlertAction(title: "웹에서 검색하기", style: .default) { [weak self] _ in
            self?.getPhotoFromWeb()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(gallery)
        alert.addAction(webSearch)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func getPhotoFromGallery() {
        self.present(self.phpicker, animated: true)
    }
    
    func getPhotoFromWeb() {
        let vc = SearchViewController()
        
        vc.imageSendClosure = { url in
            self.photoImage.load(from: url)
        }
        
        self.present(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        [photoImage, photoChangeButton].forEach { view.addSubview($0) }
        
        photoChangeButton.addTarget(self, action: #selector(photoChangeButtonClicked), for: .touchUpInside)
        
        phpicker.delegate = self
    }
    
    override func setConstraints() {
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        photoChangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
}

extension PhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self.photoImage.image = image
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
    
}
