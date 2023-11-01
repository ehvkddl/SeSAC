//
//  SimpleTableViewExample.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimpleTableViewExampleViewController : UIViewController, UITableViewDelegate {
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()

        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.accessoryType = .detailButton
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                let alertView = UIAlertController(title: "RxExample", message: "Tapped `\(value)`", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                alertView.addAction(ok)
                self.present(alertView, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                let alertView = UIAlertController(title: "RxExample", message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .cancel)
                alertView.addAction(ok)
                self.present(alertView, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

    }
    
    func configureView() {
        [tableView].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
