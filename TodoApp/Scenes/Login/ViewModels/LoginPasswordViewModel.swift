//
//  LoginPasswordViewModel.swift
//  RxUserLogin
//
//  Created by ALEMDAR on 18.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

class LoginPasswordViewModel: FieldViewModel {
    
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var title: String = "Password"
    var errorMessage: String = "Please enter a valid password!"
    
    func isValid() -> Bool {
        let pattern = "^(?=.*[A-Z])(?=.*?[0-9]).{6,}$"
        guard validateString(value.value, pattern: pattern) else {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
        
    }
        
}
