//
//  Example1ViewController.swift
//  CodeBase
//
//  Created by do hee kim on 2023/08/22.
//

import UIKit
import SnapKit

class Example1ViewController: UIViewController {
    
    let example1ImageView = {
        let imageview = UIImageView()
        
        imageview.backgroundColor = .lightGray
        
        return imageview
    }()
    
    let titleTextField = {
        let tf = UITextField()
        
        tf.placeholder = "제목을 입력해주세요"
        tf.textAlignment = .center
        tf.borderStyle = .line
        
        return tf
    }()
    
    let dateTextField = {
        let tf = UITextField()
        
        tf.placeholder = "날짜를 입력해주세요"
        tf.textAlignment = .center
        tf.borderStyle = .line
        
        return tf
    }()
    
    let contentTextView = {
        let tv = UITextView()
        
        tv.layer.borderWidth = 1
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
    }

}

extension Example1ViewController {
    
    func configureUI() {
        [example1ImageView, titleTextField, dateTextField, contentTextView].forEach { view.addSubview($0) }
        
        example1ImageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(200)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(example1ImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.height.equalTo(50)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.horizontalEdges.equalTo(view).inset(20)
        }
    }
    
}
