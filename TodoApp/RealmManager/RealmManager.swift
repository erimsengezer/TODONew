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
    
}
