//
//  BaseViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import UIKit

class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    
    var viewModel: ViewModel = ViewModel()
    
    var viewModelData: ViewModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        layout()
        bind()
    }
    
    func setupUI() {}
    
    func layout() {}
    
    func bind() {}
    
    func hideTabBar(){
        tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar(){
        tabBarController?.tabBar.isHidden = false
    }
}
