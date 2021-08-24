//
//  RegisterEmailViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 23.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterEmailViewModel: FieldViewModel {
    
    var value: BehaviorRelay<String> = BehaviorRelay(value: "")
    var errorValue: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    var title: String = "Email"
    var errorMessage: String = "Please enter a valid email!"
    
    func isValid() -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        guard validateString(value.value, pattern: pattern) else {
            errorValue.accept(errorMessage)
            return false
        }
        errorValue.accept(nil)
        return true
    }
}
