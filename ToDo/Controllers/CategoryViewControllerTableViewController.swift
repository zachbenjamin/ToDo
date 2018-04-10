//
//  CategoryViewControllerTableViewController.swift
//  ToDo
//
//  Created by Zach Benjamin on 4/1/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    
    
    
    
    
    //MARK: -- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
    
        cell.textLabel?.text = category.name
    
        
        return cell
    }
   
    
    
    
    
    
    //MARK: -- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
    
    
    
    
    //MARK: -- Data Manipulation
    
    func save(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error saving context: \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
    
    func loadData() {
        
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
   
    
    
    
    
    //MARK: -- Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let addedCategory = Category()
            addedCategory.name = textField.text!
            
            self.save(category: addedCategory)
        }

        alert.addAction(action)

        alert.addTextField { (alertTextField) in
            textField = alertTextField
            alertTextField.placeholder = "new item"
        }
        
            present(alert, animated: true, completion: nil)
            
        
    }
}
    

    








