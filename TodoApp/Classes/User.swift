//
//  User.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RealmSwift

class User {
    
    var id: Int = 0
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var isNotificationOpen: Bool = false
    var isVibrationOpen: Bool = false
    
    var realm: Realm? {
        return RealmManager.shared.realm
    }
    
    init() {}
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    /*
     Checks user email address and if exists then returns true otherwise false
     */
    func isEmailExist() -> Bool {

        let user = realm?.objects(RealmUser.self).filter("email =='\(email)'").first
        
        if let _ = user {
            return true
        }
        return false
        
    }
    
    /*
     Checks user credentials and if exists then returns itself otherwise nil
     */
    func getUser() -> User? {
        
        let user = realm?.objects(RealmUser.self).filter("email =='\(email)' AND password =='\(password)'").first
        
        if let user = user {
            self.id = user.id
            return self
        }
        
        return nil
        
    }
    
    /*
     Checks user credentials and if exists then returns itself otherwise nil
     */
    func getUserById(id: Int) -> User? {
 
        let user = realm?.objects(RealmUser.self).filter("id == %@",id).first

        if let user = user {
            self.id = user.id
            self.fullName = user.fullName
            self.email = user.email
            self.isNotificationOpen = user.isNotificationOpen
            self.isVibrationOpen = user.isVibrationOpen
            return self
        }
        return nil
        
    }
    
    
    /*
     Returns the unique user id for new user registrations.
     */
    func incrementID() -> Int {
        return (realm?.objects(RealmUser.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    /*
     Inserts this user in realm database
     */
    func insertToRealm(){
        
        let user = RealmUser()
        
        user.id = incrementID()
        user.email = email
        user.password = password
        
        do {
            try realm?.write {
                realm?.add(user)
            }
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func setIsVibrationOpen(state: Bool) {
        
        isVibrationOpen = state
        
        let user = realm?.objects(RealmUser.self).filter("id == %@",id).first
        
        if let user = user {
            do {
                try realm?.write {
                    user.isVibrationOpen = state
                }
            }catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func setIsNotificationOpen(state: Bool) {
        
        isNotificationOpen = state
        
        let user = realm?.objects(RealmUser.self).filter("id == %@",id).first
        
        if let user = user {
            do {
                try realm?.write {
                    user.isNotificationOpen = state
                }
            }catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
}
