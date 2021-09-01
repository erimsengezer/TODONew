//
//  NewTaskCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 31.08.2021.
//

import UIKit

protocol NewTaskCoordinatorProtocol {
    
}

class NewTaskCoordinator: Coordinator {
    
    private enum Constants {
        enum NavigationBar {
            static let title: String = "NEW TASK"
        }
        enum TabBar {
            static let imageName: String = "tabbar-icon-newtask"
        }
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
     
        let newTaskVC = NewTaskViewController()
        navigationController = UINavigationController(rootViewController: newTaskVC)
        navigationController.navigationBar.topItem?.title = Constants.NavigationBar.title
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.TabBar.imageName), tag: 100)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}
