//
//  ProfileViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 2.09.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProfileViewModelProtocol {
    func load()
}

class ProfileViewModel: BaseViewModel {
    
    var user: BehaviorRelay<User?> = BehaviorRelay(value: nil)
    
    func fetchUser(){
        user.accept(User().getUserById(id: UserDefaults.standard.getLoggedUserID()))
    }
    
}

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func load() {
        fetchUser()
    }
    
}
