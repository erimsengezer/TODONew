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
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
     
        guard let appCoordinator = UIApplication.shared.appCoordinator else { return }
        let homeVC = HomeViewController()
        
        homeVC.tabBarItem.title = "saa"
        navigationController = UINavigationController(rootViewController: homeVC)
    }
}
