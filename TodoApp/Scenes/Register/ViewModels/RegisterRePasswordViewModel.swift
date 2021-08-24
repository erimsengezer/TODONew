//
//  RegisterRePasswordViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 24.08.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class RegisterRePasswordViewModel: FieldViewModel {
    
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var title: String = "Confirm Password"
    var errorMessage: String = "Please enter a password minimum six characters including one uppercase letter and one digit!"
    var secondErrorMessage: String = "Passwords does not matched!"
    
    func isValid() -> Bool {
        let pattern = "^(?=.*[A-Z])(?=.*?[0-9]).{6,}$"
        guard validateString(value.value, pattern: pattern) else {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
        
    }
    
    func isMatches(password: String) -> Bool {
        if password != value.value {
            errorValue.accept(secondErrorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
        
}
