//
//  TabBarCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 18.08.2021.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
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
        
        setupUI()
        tabBarController.setViewControllers(controllers, animated: false)
    }
    
    private func setupUI(){
        
        let tabBar = tabBarController.tabBar
        tabBar.tintColor = Color.secondary
        tabBar.barTintColor = Color.primary
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: Color.secondary, size: CGSize(width: tabBar.frame.width/1, height: tabBar.frame.height), lineWidth: 4.0)
    }

}
