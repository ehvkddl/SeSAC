//
//  CustomTableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

class CustomTableViewController: UITableViewController {

    var todo = ToDoInformation() {
        didSet { // 변수가 달라짐을 감지!
            print("DidSet")
            tableView.reloadData()
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 90
        
        searchBar.placeholder = "할 일을 입력해주세요"
        searchBar.searchTextField.addTarget(self, action: #selector(searchBarReturnTapped), for: .editingDidEndOnExit)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentifier) as? CustomTableViewCell else { return CustomTableViewCell() }
        
        let row = todo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todo.list[indexPath.row].done.toggle()
        
//        tableView.reloadData()
    }
    
    // 삭제
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 제거 -> 갱신
        todo.list.remove(at: indexPath.row)
        
//        tableView.reloadData()
    }

    @objc
    func likeButtonClicked(_ sender: UIButton) {
        print("HI \(sender.tag)")
        
        todo.list[sender.tag].like.toggle()
        
//        tableView.reloadData()
    }
    
    @objc
    func searchBarReturnTapped() {
        // ToDo 항목을
        let data = ToDo(main: searchBar.text!, sub: "23.08.01", like: false, done: false)
        // list에 추가
        todo.list.insert(data, at: 0)
        //UX
        searchBar.text = ""
        // 갱신
//        tableView.reloadData()
    }
    
}
