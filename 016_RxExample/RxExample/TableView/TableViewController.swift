//
//  TableViewController.swift
//  RxExample
//
//  Created by do hee kim on 2023/11/01.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UIViewController {
    
    lazy var tableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return view
    }()
    
    let label = UILabel()
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureView()
        setConstraints()
        setTableView()
    }
    
    func configureView() {
        [tableView, label].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(label.snp.top)
        }
        
        label.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
    }
    
    func setTableView() {
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
            var content = cell.defaultContentConfiguration()
            content.text = "\(element) @row \(row)"
            cell.contentConfiguration = content
            
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { "\($0)를 클릭했습니다." }
//            .bind { value in
//                let alertView = UIAlertController(title: "RxExample", message: "\(value)", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "OK", style: .cancel)
//                alertView.addAction(ok)
//                self.present(alertView, animated: true, completion: nil)
//            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
}
