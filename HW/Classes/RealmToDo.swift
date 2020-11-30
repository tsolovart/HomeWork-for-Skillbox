//
//  RealmToDo.swift
//  HW
//
//  Created by Artem Tsolov on 01.11.2020.
//

import Foundation
import RealmSwift


class TasksList: Object {
    @objc dynamic var task = ""
    
}

class Persistence {
    static let shared = Persistence()
    private let realm = try! Realm()
    
    func saveNewTask(task: TasksList){
        
        try! realm.write {
            realm.add(task)
        }
    }
    func obtainTasks() -> [TasksList] {
        let items = realm.objects(TasksList.self)
        print (items)
        return Array(items)
    }
    
    func deleteTask(task: TasksList) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    
    
}


