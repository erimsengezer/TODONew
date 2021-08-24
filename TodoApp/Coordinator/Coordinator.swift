//
//  Coordinator.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import UIKit

protocol  Coordinator: class {
    var navigationController: UINavigationController { get }
    
    func start()
}
