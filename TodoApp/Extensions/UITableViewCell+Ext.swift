//
//  UITableViewCell+Ext.swift
//  TodoApp
//
//  Created by ALEMDAR on 25.08.2021.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
