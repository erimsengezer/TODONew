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
    
    func setEmptyImage(_ imageName: String) {
        
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 150, height: 150)
        imageView.frame.origin = CGPoint(x: self.bounds.size.width/2 - 75, y: self.bounds.size.height/2 - 75)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)?.setColor(color: UIColor.black.withAlphaComponent(0.5))

        containerView.addSubview(imageView)
        backgroundView = containerView
    }

    func removeEmptyImage() {
        backgroundView = nil
    }
    
}
