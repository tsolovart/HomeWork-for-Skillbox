//
//  CoreDataToDo.swift
//  HW
//
//  Created by Artem Tsolov on 12.11.2020.
//

import Foundation
import UIKit
import CoreData

class Persistence2 {
    
    static let shared = Persistence2()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func saveTask(name: String){
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.name = name
        
        do {
            try! context.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
    
            
      
        
    }
    
    func getTasks() -> [Tasks]{

        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            let item = try! context.fetch(fetchRequest)
            return Array(item)
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        
            
    }
//  Delete all objects
//
//    func deleteTask(name: Tasks){
//        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
//        if let tasks = try? context.fetch(fetchRequest){
//            for task in tasks {
//                context.delete(task)
//        }
//    }
//        try! context.save()
//    }
    
    func deleteTask(name: Tasks) {

            context.delete(name)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error), description: \(error.userInfo)")
            }
        }
    
    
    
    
        
}
    
    
        
    
    
    
    


