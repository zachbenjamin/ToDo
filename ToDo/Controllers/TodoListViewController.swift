//
//  ViewController.swift
//  ToDo
//
//  Created by Zach Benjamin on 3/24/18.
//  Copyright © 2018 Zach Benjamin. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemsArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadData()
        }
    }
    
    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) .first?.appendingPathComponent("items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].isDone = !itemsArray[indexPath.row].isDone
        
        //context.delete(itemsArray[indexPath.row])
        //itemsArray.remove(at:indexPath.row)
        
        saveItems()
       
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
   
    
    
    //MARK: - Add New Items
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let addedItem = Item(context: self.context)
            addedItem.title = textField.text!
            addedItem.isDone = false
            addedItem.parentCategory = self.selectedCategory
            self.itemsArray.append(addedItem)
            
            self.saveItems()

            
            self.tableView.reloadData() }
       

        
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "new item"
                textField = alertTextField
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: -- Model Manipulation
    func saveItems() {
        do {
             try context.save()
        } catch {
            print("error saving items: \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadData(with request : NSFetchRequest<Item> = Item.fetchRequest() , predicate: NSPredicate? = nil) {
      
        let CategoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [CategoryPredicate, additionalPredicate])
        } else {
            request.predicate = CategoryPredicate
        }
    
        do {
        itemsArray = try context.fetch(request)
        } catch {
            print("error fetching data from context: error: \(error)")
        }
        
        tableView.reloadData()
        
    }


}


// MARK: -- search bar methods
extension TodoListViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
   
        loadData(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
           
        }
    }
    
}








