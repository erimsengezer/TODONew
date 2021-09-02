//
//  ProfileCoordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 2.09.2021.
//

import UIKit

protocol ProfileCoordinatorProtocol {
    
}

class ProfileCoordinator: Coordinator {
    
    private enum Constants {
        enum NavigationBar {
            static let title: String = "PROFILE"
        }
        enum TabBar {
            static let imageName: String = "tabbar-icon-profile"
        }
    }
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
     
        let profileVC = ProfileViewController()
        navigationController = UINavigationController(rootViewController: profileVC)
        navigationController.navigationBar.topItem?.title = Constants.NavigationBar.title
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.TabBar.imageName), tag: 100)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
}
