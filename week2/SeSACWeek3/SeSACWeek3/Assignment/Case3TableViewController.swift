//
//  Case3TableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/28.
//

import UIKit

class Case3TableViewController: UITableViewController {

    var todos: [Todo] = []
    
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let todo = textField.text else { return }
        
        todos.append(Todo(todo: todo,
                          isDone: false,
                          isFavorite: false))
        
        textField.text = ""
    }
    

}
