//
//  PhotoViewController.swift
//  PhotoGram
//
//  Created by do hee kim on 2023/09/03.
//

import UIKit
import PhotosUI

class AddDiaryViewController: BaseViewController {

    let repository = DiaryRepository()
    var imageUrl: String?
    
    let photoImage = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    let photoChangeButton = {
        let btn = UIButton()
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "photo")
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .black
        btn.configuration = config
        
        btn.clipsToBounds = true
        
        return btn
    }()
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko-KR")
        picker.timeZone = .autoupdatingCurrent
        return picker
    }()
    
    lazy var dateTextField = {
        let view = WriteTextField()
        view.placeholder = "날짜를 선택해주세요"
        view.text = Date().description
        view.inputView = datePicker
        view.tintColor = .clear
        return view
    }()
    
    let titleTextField = {
        let view = WriteTextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    let contentTextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 14)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var phpicker = {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        return picker
    }()
    
    let tapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    override func viewDidLayoutSubviews() {
        photoChangeButton.layer.cornerRadius = photoChangeButton.frame.width * 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addGestureRecognizer(tapGestureRecognizer)
        [photoImage, photoChangeButton, dateTextField, titleTextField, contentTextView].forEach { view.addSubview($0) }
        
        photoChangeButton.addTarget(self, action: #selector(photoChangeButtonClicked), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        tapGestureRecognizer.addTarget(self, action: #selector(didTapView))
    }
    
    override func setConstraints() {
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(14)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        photoChangeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(photoImage).inset(10)
            make.size.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(photoImage)
            make.height.equalTo(45)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(photoImage)
            make.height.equalTo(45)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(photoImage)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
    
    override func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(addDiaryButtonClicked))
    }
    
}

extension AddDiaryViewController {
    
    @objc func photoChangeButtonClicked() {
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
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
        dateTextField.text = String(sender.date.description)
    }
    
    func getPhotoFromGallery() {
        self.present(self.phpicker, animated: true)
    }
    
    func getPhotoFromWeb() {
        let vc = SearchViewController()
        
        vc.imageSendClosure = { url in
            self.photoImage.load(from: url)
            self.imageUrl = url
        }
        
        self.present(vc, animated: true)
    }
    
    @objc func addDiaryButtonClicked() {
        let item = Diary(title: titleTextField.text!,
                         date: datePicker.date,
                         content: contentTextView.text,
                         photoURL: self.imageUrl)
        
        repository.createItem(item)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

extension AddDiaryViewController: PHPickerViewControllerDelegate {
    
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
