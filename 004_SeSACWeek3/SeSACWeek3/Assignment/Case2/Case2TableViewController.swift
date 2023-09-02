//
//  Case2TableViewController.swift
//  SeSACWeek3
//
//  Created by do hee kim on 2023/07/27.
//

import UIKit

class Case2TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Setting(rawValue: section)?.text
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let header = Setting(rawValue: section) else {
            print("등록된 section 없음!")
            return 0
        }
        
        return header.setting.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else { return UITableViewCell() }
        
        guard let header = Setting(rawValue: indexPath.section) else {
            print("등록된 section 없음!")
            return UITableViewCell()
        }
        cell.textLabel?.text = header.setting[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
