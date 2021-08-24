//
//  RegisterViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 23.08.2021.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class RegisterViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    var emailFieldViewModel = RegisterEmailViewModel()
    var passwordFieldViewModel = RegisterPasswordViewModel()
    var repasswordFieldViewModel = RegisterRePasswordViewModel()
    
    var isSuccess = BehaviorRelay(value: false)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    
    func isValidForm() -> Bool {
        return emailFieldViewModel.isValid() && passwordFieldViewModel.isValid()
            && repasswordFieldViewModel.isMatches(password: passwordFieldViewModel.value.value)
    }
    
    func register(){
        
        let email = emailFieldViewModel.value.value
        let password = passwordFieldViewModel.value.value
        
        let user = User(email: email, password: password)
        
        if user.isEmailExist() {
            AlertManager.shared.showAlert(layout: .messageView, type: .error, message: "This e-mail address has been used")
            return
        }

        user.insertToRealm()
        
        AlertManager.shared.showAlert(layout: .messageView, type: .success, message: "Successfully registered!")
        
        isSuccess.accept(true)
    }
    
    func showAlert(){
        let emailError = emailFieldViewModel.errorValue.value
        if emailError != nil {
            AlertManager.shared.showAlert(layout: .messageView, type: .error, message: emailError)
        }
        
        let passwordError = passwordFieldViewModel.errorValue.value
        if passwordError != nil {
            AlertManager.shared.showAlert(layout: .messageView, type: .error, message: passwordError)
        }
        
        let repasswordError = repasswordFieldViewModel.errorValue.value
        if repasswordError != nil {
            AlertManager.shared.showAlert(layout: .messageView, type: .error, message: repasswordError)
        }
    }
    
}
