//
//  User.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RealmSwift

class User {
    
    var id: Int?
    var email: String
    var password: String
    
    var realm: Realm? {
        return RealmManager.shared.realm
    }
    
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
    
}
