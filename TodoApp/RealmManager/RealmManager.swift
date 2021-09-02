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
    
    func fetchTasksByDate() -> [Date: Results<RealmTask>]{
        
        var groupedItems = [Date:Results<RealmTask>]()
        var itemDates = [Date]()
        
        let items = realm?.objects(RealmTask.self)
        
        guard let myitems = items else { return [:] }
        
        itemDates = myitems.reduce(into: [Date](), { results, currentItem in
            
            let date = currentItem.date
            let beginningOfDay = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: date), month: Calendar.current.component(.month, from: date), day: Calendar.current.component(.day, from: date), hour: 0, minute: 0, second: 0))!
            let endOfDay = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: date), month: Calendar.current.component(.month, from: date), day: Calendar.current.component(.day, from: date), hour: 23, minute: 59, second: 59))!
                        
            if !results.contains(where: { addedDate -> Bool in
                return addedDate >= beginningOfDay && addedDate <= endOfDay
            }) {
                results.append(beginningOfDay)
            }
            
        })
        
        //Filter each Item in realm based on their date property and assign the results to the dictionary
        groupedItems = itemDates.reduce(into: [Date:Results<RealmTask>](), { results, date in
            
            let beginningOfDay = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: date), month: Calendar.current.component(.month, from: date), day: Calendar.current.component(.day, from: date), hour: 0, minute: 0, second: 0))!
            
            let endOfDay = Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: date), month: Calendar.current.component(.month, from: date), day: Calendar.current.component(.day, from: date), hour: 23, minute: 59, second: 59))!
            
            results[beginningOfDay] = realm?.objects(RealmTask.self).filter("date >= %@ AND date <= %@", beginningOfDay, endOfDay)
            
        })
        
        return groupedItems
    }
    
}
