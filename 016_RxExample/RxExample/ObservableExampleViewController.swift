//
//  ObservableExampleViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ObservableExampleViewController: UIViewController {
    
    let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
    let itemsB = [2.3, 2.0, 1.3]
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        justExample()
        ofExample()
        fromExample()
        takeExample()
    }
    
    func justExample() {
        Observable.just([itemsA])
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)

    }
    
    func ofExample() {
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func fromExample() {
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func takeExample() {
        Observable.repeatElement("Chap")
            .take(5)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - \(error)")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
    }
    
}
