//
//  ViewController.swift
//  ToDo
//
//  Created by Zach Benjamin on 3/24/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = ["Find Mike", "Buy Eggos", "Something Else"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType != .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.itemsArray.append(textField.text!)
            self.tableView.reloadData()       }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}



