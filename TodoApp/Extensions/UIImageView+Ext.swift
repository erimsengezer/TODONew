//
//  UIImageView+Ext.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
}
