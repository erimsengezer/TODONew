//
//  Task.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RealmSwift

enum TaskPriority: String {
    case low = "low"
    case medium = "medium"
    case high = "high"
    case urgent = "urgent"
}

class Task {
    
    var id: Int?
    var name: String
    var priority: TaskPriority
    var isDone: Bool
    var isAlarm: Bool
    var isNotification: Bool
    var date: Date
    
    var realm: Realm? {
        return RealmManager.shared.realm
    }
    
    init(name: String, priority: TaskPriority, isDone: Bool, isAlarm: Bool, isNotification: Bool, date: Date) {
        self.name = name
        self.priority = priority
        self.isDone = isDone
        self.isAlarm = isAlarm
        self.isNotification = isNotification
        self.date = date
        
    }
    
    /*
     Returns the unique task id for new task registrations.
     */
    func incrementID() -> Int {
        return (realm?.objects(RealmTask.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func insertToRealm() {
        
        let task = RealmTask()
        
        task.id = incrementID()
        task.name = name
        task.priority = priority.rawValue
        task.isDone = isDone
        task.isAlarm = isAlarm
        task.isNotification = isNotification
        task.date = date
       
        do {
            try realm?.write {
                realm?.add(task)
            }
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func setTaskToDone(){
        
        isDone = true
        
        guard let id = id else { return }
        
        let task = realm?.objects(RealmTask.self).filter("id == %@", id).first
        
        do {
            try realm?.write {
                task?.isDone = true
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func setTaskToNotDone(){
        
        isDone = false
        
        guard let id = id else { return }
        
        let task = realm?.objects(RealmTask.self).filter("id == %@", id).first
        do {
            try realm?.write {
                task?.isDone = false
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
}


