//
//  Coordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
