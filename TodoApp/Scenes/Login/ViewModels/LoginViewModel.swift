//
//  RegisterViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 16.08.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class LoginViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    var emailFieldViewModel = LoginEmailViewModel()
    var passwordFieldViewModel = LoginPasswordViewModel()
    
    var isSuccess = BehaviorRelay(value: false)

    
    func isValidForm() -> Bool {
        return emailFieldViewModel.isValid() && passwordFieldViewModel.isValid()
    }
    
    func login(){
        
        let email = emailFieldViewModel.value.value
        let password = passwordFieldViewModel.value.value

        let user = User(email: email, password: password)
        
        if let user = user.getUser() {
            
            UserDefaults.standard.setIsLoggedIn(value: true)
            UserDefaults.standard.setLoggedUserID(value: user.id)
            
            AlertManager.shared.showAlert(layout: .messageView, type: .success, message: "Successfully logged in.")
            
            UIApplication.shared.appCoordinator?.makeRootControllerAsTabBarController()
            
            return
        }
        
        AlertManager.shared.showAlert(layout: .messageView, type: .error, message: "No such user found!")
        
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
    }
    
}
