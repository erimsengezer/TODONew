//
//  AlertManager.swift
//  TodoApp
//
//  Created by ALEMDAR on 23.08.2021.
//

import Foundation
import SwiftMessages

class AlertManager {
    
    static let shared: AlertManager = AlertManager()
    
    private init() {
        
    }
    
    func showAlert(layout: MessageView.Layout, type: Theme, message: String?){
        
        let view = MessageView.viewFromNib(layout: layout)
        
        view.configureTheme(type)
        view.configureDropShadow()
        view.configureContent(body: message ?? "")
        
        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
    
}
