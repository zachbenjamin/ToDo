//
//  ViewController.swift
//  ToDo
//
//  Created by Zach Benjamin on 3/24/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemsArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemsArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggos"
        itemsArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Other Stuff"
        itemsArray.append(newItem3)
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemsArray = items
        }
        
    }

    // MARK: - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        // value = condition ? ifTrue : ifFalse
        
        cell.accessoryType  = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if itemsArray[indexPath.row].isDone == true {
            itemsArray[indexPath.row].isDone = false
        } else {
            itemsArray[indexPath.row].isDone = true

        }
        
        itemsArray[indexPath.row].isDone = !itemsArray[indexPath.row].isDone
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let addedItem = Item()
            addedItem.title = textField.text!
            self.itemsArray.append(addedItem)
            
            self.defaults.set(self.itemsArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData() }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    


}



