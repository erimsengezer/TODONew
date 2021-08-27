//
//  RealmManager.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared: RealmManager = RealmManager()
    
    var realm: Realm? {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm
    }
    
    private init() {
        
    }
    
    
    func fetchAllTasks() -> [RealmTask]? {
        return realm?.objects(RealmTask.self).toArray(ofType: RealmTask.self)
    }
    
    func fetchTodayTasks() -> [RealmTask]? {
        
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            guard let date = Calendar.current.date(byAdding: components, to: todayStart) else { return Date() }
            return date
        }()
        
        return realm?.objects(RealmTask.self).filter("date BETWEEN %@", [todayStart, todayEnd]).toArray(ofType: RealmTask.self)

    }
    
}
