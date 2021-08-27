//
//  UIImage+Ext.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import Foundation
import UIKit

extension UIImage {

    func setColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        color.setFill()
        
        UIRectFill(CGRect(x: 0, y: size.height-lineWidth, width: size.width, height: lineWidth))
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        
        UIGraphicsEndImageContext()
        
        return image
    }

}

