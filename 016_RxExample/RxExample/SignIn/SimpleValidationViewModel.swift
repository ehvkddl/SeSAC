//
//  SimpleValidationViewModel.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/05.
//

import Foundation
import RxSwift
import RxCocoa

class SimpleValidationViewModel {
    
    let useranmeValid = PublishSubject<Bool>()
    let passwordValid = PublishSubject<Bool>()
    
    lazy var everythingValid = Observable.combineLatest(self.useranmeValid, self.passwordValid) {
        return $0 && $01
    }
        .share()
    
}
