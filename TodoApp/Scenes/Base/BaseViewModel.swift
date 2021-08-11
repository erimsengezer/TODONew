//
//  BaseViewModel.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import Foundation

protocol ViewModelData {}

protocol BaseViewModelDelegate {
    
}

class BaseViewModel {
    
    var delegate: BaseViewModelDelegate?
    
    required init() {}
}
