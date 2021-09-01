//
//  SchedulerCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 27.08.2021.
//

import UIKit

protocol SchedulerCoordinatorProtocol {
    
}

class SchedulerCoordinator: Coordinator {
    
    private enum Constants {
        enum NavigationBar {
            static let title: String = "SCHEDULER"
        }
        enum TabBar {
            static let imageName: String = "tabbar-icon-scheduler"
        }
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
     
        let schedulerVC = SchedulerViewController()
        navigationController = UINavigationController(rootViewController: schedulerVC)
        navigationController.navigationBar.topItem?.title = Constants.NavigationBar.title
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.TabBar.imageName), tag: 100)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}
