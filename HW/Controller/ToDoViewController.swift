//
//  ToDoViewController.swift
//  HW
//
//  Created by Artem Tsolov on 28.10.2020.
//

import UIKit
import RealmSwift


class ToDoViewController: UITableViewController {
    

    var toDoList = [TasksList()]
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear (true)
       reload()
    }
    
    func reload() {
        toDoList = Persistence.shared.obtainTasks()
      

        tableView.reloadData()
    }
    


    

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "New ToDo", message: "What do you want to do?", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        alertVC.addTextField(configurationHandler: {(textField) in
            alertTextField = textField
           alertTextField.placeholder = "New task"
       })

            
          let cancelAction = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
          alertVC.addAction(cancelAction)
          
          let addAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) -> Void in
            
            let newToDoListItem = TasksList()
            newToDoListItem.task = alertTextField.text!
              
            Persistence.shared.saveNewTask(task: newToDoListItem)
            self.reload()
            
            
          }
          
          alertVC.addAction(addAction)
          present(alertVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel!.text = item.task
        tableView.reloadRows(at: [indexPath], with: .automatic)
       
        
        
        return cell
    }
    

//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if (editingStyle == .delete) {
//            let item = toDoList[indexPath.row]
//
//            Persistence.shared.deleteTask(task: item)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//    }
//
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let item = toDoList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

        Persistence.shared.deleteTask(task: item)
            self.reload()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    
    }

}
