//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by do hee kim on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneViewModel {
    
    let phoneNumber = BehaviorSubject(value: "010")
    
    let buttonColor = PublishSubject<String>()
    let buttonEnable = PublishSubject<Bool>()
    
    let disposeBag = DisposeBag()
    
    init() {
        phoneNumber
            .map { $0.count > 10 }
            .subscribe(with: self) { owner, value in
                owner.buttonColor.onNext(value ? "00CC33" : "FF0000")
                owner.buttonEnable.onNext(value)
            }
            .disposed(by: disposeBag)
    }
    
}
