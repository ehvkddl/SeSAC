//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by do hee kim on 2023/11/03.
//

import Foundation
import RxSwift
import RxCocoa

class BirthdayViewModel {
    
    let birthDay = BehaviorSubject(value: Date.now)
    let year = PublishSubject<Int>()
    let month = PublishSubject<Int>()
    let day = PublishSubject<Int>()
    
    let age = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    init() {
        birthDay
            .subscribe(with: self) { owner, value in
                let calendar = Calendar.current
                let component = calendar.dateComponents([.year, .month, .day], from: value)
                guard let year = component.year, let month = component.month, let day = component.day else { return }
                
                owner.year.onNext(year)
                owner.month.onNext(month)
                owner.day.onNext(day)
                
                let nowComponent = calendar.dateComponents([.year, .month], from: Date.now)
                guard let nowYear = nowComponent.year, let nowMonth = nowComponent.month else { return }
                
                let age = nowYear - year - (month > nowMonth ? 1 : 0)
                owner.age.onNext(age)
                
            }
            .disposed(by: disposeBag)
    }
    
}
