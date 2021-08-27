//
//  RealmTask.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RealmSwift

class RealmTask: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var priority: String
    @Persisted var isDone: Bool
    @Persisted var isAlarm: Bool
    @Persisted var isNotification: Bool
    @Persisted var date: Date
}
