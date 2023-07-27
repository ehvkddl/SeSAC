//
//  Case3TableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

class Case3ViewController: UIViewController {

    var todos: [Todo] = []
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let todo = textField.text else { return }
        
        todos.append(Todo(todo: todo,
                          isDone: false,
                          isFavorite: false))
        
        textField.text = ""
        
        tableView.reloadData()
    }

}

extension Case3ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? Case3TableViewCell else { return UITableViewCell() }

        cell.todo.text = todos[indexPath.row].todo

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
