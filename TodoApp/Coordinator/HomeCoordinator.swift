//
//  HomeCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 18.08.2021.
//

import UIKit

protocol HomeCoordinatorProtocol {
    
}

class HomeCoordinator: Coordinator {
    
    private enum Constants {
        enum NavigationBar {
            static let title: String = "TO-DO"
        }
        enum TabBar {
            static let imageName: String = "tabbar-icon-home"
        }
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
     
        let homeVC = HomeViewController()
        navigationController = UINavigationController(rootViewController: homeVC)
        navigationController.navigationBar.topItem?.title = Constants.NavigationBar.title
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.TabBar.imageName), tag: 100)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}
