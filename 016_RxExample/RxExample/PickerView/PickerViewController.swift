//
//  PickerViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    
    let pickerView = UIPickerView()
    let label = {
        let lbl = UILabel()
        lbl.textColor = .black
        return lbl
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()
        setPickerView()
    }
    
    func configureView() {
        [pickerView, label].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        pickerView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(300)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.bottom).offset(50)
            make.centerX.equalTo(view)
        }
    }
    
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in //Int, Sequence Element
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: label.rx.text)
//            .bind(onNext: { value in
//                print(value)
//            })
//            .subscribe(onNext: { value in
//                print(value)
//            })
            .disposed(by: disposeBag)
    }
    
}
