//
//  User.swift
//  TodoApp
//
//  Created by ALEMDAR on 18.08.2021.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var fullName: String
    @Persisted var email: String
    @Persisted var password: String
    @Persisted var isNotificationOpen: Bool
    @Persisted var isVibrationOpen: Bool
}
