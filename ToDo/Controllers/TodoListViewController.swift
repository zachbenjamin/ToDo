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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
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
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         itemsArray[indexPath.row].isDone = !itemsArray[indexPath.row].isDone
        
        saveItems()
       
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
            
            self.tableView.reloadData() }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        
        saveItems()
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: -- Model Manipulation
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
            tableView.reloadData()
        } catch {
            print("error writing and encoding data: \(error)")
        }
    }
    
    func loadData() {
        
        if let data =  try? Data.init(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemsArray =  try decoder.decode([Item].self, from: data)
            } catch {
                print("error loading data: \(error)")
            }
        }
    }


}



