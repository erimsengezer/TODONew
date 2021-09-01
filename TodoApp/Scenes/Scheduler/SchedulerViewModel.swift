//
//  SchedulerViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 27.08.2021.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

protocol SchedulerViewModelProtocol {
    func loadTasks()
    func loadTasksByDate()
}

class SchedulerViewModel: BaseViewModel {
    
    var taskSections: BehaviorRelay<[SchedulerSection]> = BehaviorRelay(value: [])
    var tasks: BehaviorRelay<[Task]> = BehaviorRelay(value: [])
    
    private func fetchTasks(){
        
        guard let realmTasks = RealmManager.shared.fetchAllTasks() else { return }
        
        var tasks: [Task] = []
        
        for realmTask in realmTasks {
            
            guard let priority = strToTaskPriority(priority: realmTask.priority) else { return }
            
            let task = Task(name: realmTask.name,
                            priority: priority,
                            isDone: realmTask.isDone,
                            isAlarm: realmTask.isAlarm,
                            isNotification: realmTask.isNotification,
                            date: realmTask.date)
            task.id = realmTask.id
            tasks.append(task)
        }
        self.tasks.accept(tasks)
    }
    
    private func fetchTasksByDate(){
        
        let realmTasks = RealmManager.shared.fetchTasksByDate()
        var sections = [SchedulerSection]()
        var subTasks = [Task]()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy"
        
        for dateTasks in realmTasks {
        
            subTasks.removeAll()
            
            for dateTask in dateTasks.value {
                let task = Task(name: dateTask.name,
                                priority: strToTaskPriority(priority: dateTask.priority) ?? .low,
                                isDone: dateTask.isDone,
                                isAlarm: dateTask.isAlarm,
                                isNotification: dateTask.isNotification,
                                date: dateTask.date)
                task.id = dateTask.id
                
                subTasks.append(task)
            }
            
            var headerTitle: String = ""
            
            if Calendar.current.isDateInYesterday(dateTasks.key) {
                headerTitle = "Yesterday"
            }else if Calendar.current.isDateInToday(dateTasks.key) {
                headerTitle = "Today"
            }else if Calendar.current.isDateInTomorrow(dateTasks.key) {
                headerTitle = "Tomorrow"
            }else {
                headerTitle = dateFormatter.string(from: dateTasks.key)
            }
            
            let section = SchedulerSection(header: headerTitle, items: subTasks)
            sections.append(section)
        }
        
        self.taskSections.accept(sections)
    }

    private func strToTaskPriority(priority: String) -> TaskPriority? {
        
        switch priority {
        case TaskPriority.low.rawValue:
            return TaskPriority.low
        case TaskPriority.medium.rawValue:
            return TaskPriority.medium
        case TaskPriority.high.rawValue:
            return TaskPriority.high
        case TaskPriority.urgent.rawValue:
            return TaskPriority.urgent
        default:
            return nil
        }
        
    }
    
}

extension SchedulerViewModel: SchedulerViewModelProtocol {
    
    func loadTasks() {
        fetchTasks()
    }
    
    func loadTasksByDate(){
        fetchTasksByDate()
    }
}
