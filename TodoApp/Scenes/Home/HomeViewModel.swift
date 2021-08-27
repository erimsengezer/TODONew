//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelProtocol {
    func load()
}

class HomeViewModel: BaseViewModel {
    
    var tasks: BehaviorRelay<[Task]> = BehaviorRelay(value: [])
    
    private func fetchTasks(){
        
        guard let realmTasks = RealmManager.shared.fetchTodayTasks() else { return }
        
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

extension HomeViewModel: HomeViewModelProtocol {
    
    func load() {
        fetchTasks()
    }
    
}
