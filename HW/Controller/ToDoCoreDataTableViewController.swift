//
//  ToDoCoreDataTableViewController.swift
//  HW
//
//  Created by Artem Tsolov on 12.11.2020.
//

import UIKit
import CoreData

class ToDoCoreDataTableViewController: UITableViewController {
    
    var tasks: [Tasks] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear (true)
       reload()
    }
    
    func reload() {
       tasks = Persistence2.shared.getTasks()
        tableView.reloadData()
    }
    
   
    @IBAction func addAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "New ToDo", message: "What do you want to do?", preferredStyle: .alert)
                    
          let cancelAction = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
          alertVC.addAction(cancelAction)
          
          let addAction = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) -> Void in
            let tf = alertVC.textFields?.first
            if let newToDoListItem = tf?.text {
                Persistence2.shared.saveTask(name: newToDoListItem)
                self.reload()
            }
            
          }
        alertVC.addTextField { _ in }
          
          alertVC.addAction(addAction)
          present(alertVC, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCoreData", for: indexPath)
        let item = tasks[indexPath.row]
        cell.textLabel!.text = item.name
        tableView.reloadRows(at: [indexPath], with: .automatic)
       

        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
        let item = tasks[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

            Persistence2.shared.deleteTask(name: item)
            
            self.reload()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    
    }


}
