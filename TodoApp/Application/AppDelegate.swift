//
//  AppDelegate.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: ApplicationCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else { return false }
        coordinator = ApplicationCoordinator(window: window)
        coordinator?.start()
        window.makeKeyAndVisible()
        return true
    }
    
}

