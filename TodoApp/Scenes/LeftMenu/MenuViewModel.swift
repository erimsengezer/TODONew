//
//  MenuViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 27.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol MenuViewModelProtocol {
    func load()
}

class MenuViewModel: BaseViewModel {
    
    var elements: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    
    private func fetchMenuElements(){
        
        let newElements = [
            "To-do",
            "Scheduler",
            "Notifications",
            "Profile",
            "Logout"
        ]
        elements.accept(newElements)
    }
    
}


extension MenuViewModel: MenuViewModelProtocol {
    
    func load() {
        fetchMenuElements()
    }
    
}
