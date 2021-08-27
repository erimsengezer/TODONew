//
//  UITableView.swift
//  TodoApp
//
//  Created by ALEMDAR on 26.08.2021.
//

import UIKit

extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Reusable cell could not casted.")
        }
        
        return cell
    }
    
}
