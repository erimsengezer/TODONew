//
//  UserDefaults+Ext.swift
//  TodoApp
//
//  Created by ALEMDAR on 18.08.2021.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys {
        static let isLoggedIn = "isLoggedIn"
        static let loggedUserID = "loggedUserID"
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn)
    }
    
    func setIsLoggedIn(value: Bool) {
        return setValue(value, forKey: UserDefaultsKeys.isLoggedIn)
    }
    
    func getLoggedUserID() -> Int {
        return integer(forKey: UserDefaultsKeys.loggedUserID)
    }
    
    func setLoggedUserID(value: Int) {
        return setValue(value, forKey: UserDefaultsKeys.loggedUserID)
    }
    
}
