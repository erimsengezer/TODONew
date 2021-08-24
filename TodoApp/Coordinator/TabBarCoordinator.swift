//
//  TabBarCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 18.08.2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    private enum Constants {
        enum Color {
            static let tabBarTintColor: UIColor = UIColor(red: 255 / 255, green: 100 / 255, blue: 0 / 255, alpha: 1)
        }
    }
    
    var navigationController: UINavigationController
    let tabBarController: UITabBarController
    
    var homeCoordinator: Coordinator
    
    init() {
        navigationController = UINavigationController()
        tabBarController = UITabBarController()
        
        homeCoordinator = HomeCoordinator()
    }
    
    func start() {
        homeCoordinator.start()
        
        let controllers: [UIViewController] = [
            homeCoordinator.navigationController
        ]
        
        tabBarController.setViewControllers(controllers, animated: false)
    }
    
    
}
