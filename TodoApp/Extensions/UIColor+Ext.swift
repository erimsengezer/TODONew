//
//  UIColor+Ex.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
}
