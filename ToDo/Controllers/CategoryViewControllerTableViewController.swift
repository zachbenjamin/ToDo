//
//  CategoryViewControllerTableViewController.swift
//  ToDo
//
//  Created by Zach Benjamin on 4/1/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {

    var categoriesArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    //MARK: -- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoriesArray[indexPath.row]
    
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
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
        }
    }
    
    
    
    //MARK: -- Data Manipulation
    
    func saveData() {
        do {
        try context.save()
        } catch {
            print("error saving context: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
        categoriesArray = try context.fetch(request)
        } catch {
            print("error fetching data: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
   
    
    
    
    
    //MARK: -- Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let addedCategory = Category(context: self.context)
            addedCategory.name = textField.text!
            
            self.categoriesArray.append(addedCategory)
            
            self.tableView.reloadData()
            
            self.saveData()
        }

        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "new item"
            textField = alertTextField
        }
        
        
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        
    }

    
   
    
    
    
    
    



}
    

    








