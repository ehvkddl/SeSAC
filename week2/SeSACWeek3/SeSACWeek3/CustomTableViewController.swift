//
//  CustomTableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

class CustomTableViewController: UITableViewController {

    var todo = ToDoInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 90
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentifier) as? CustomTableViewCell else { return CustomTableViewCell() }
        
        let row = todo.list[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todo.list[indexPath.row].done.toggle()
        
        tableView.reloadData()
    }

}
