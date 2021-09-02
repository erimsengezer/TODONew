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
    var schedulerCoordinator: Coordinator
    var newTaskCoordinator: Coordinator
    
    init() {
        navigationController = UINavigationController()
        tabBarController = UITabBarController()
        
        homeCoordinator = HomeCoordinator()
        schedulerCoordinator = SchedulerCoordinator()
        newTaskCoordinator = NewTaskCoordinator()
    }
    
    func start() {
        
        homeCoordinator.start()
        schedulerCoordinator.start()
        newTaskCoordinator.start()
        
        let controllers: [UIViewController] = [
            homeCoordinator.navigationController,
            schedulerCoordinator.navigationController,
            newTaskCoordinator.navigationController
        ]
        
        setupUI()
        tabBarController.setViewControllers(controllers, animated: false)
    }
    
    private func setupUI(){
        
        let tabBar = tabBarController.tabBar
        tabBar.tintColor = Color.secondary
        tabBar.barTintColor = Color.primary
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: Color.secondary, size: CGSize(width: tabBar.frame.width/3, height: tabBar.frame.height), lineWidth: 4.0)
    }

}
