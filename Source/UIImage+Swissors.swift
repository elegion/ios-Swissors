//
//  UIImage+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public extension UIImage {
    func sw_tintedImage(with color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        draw(in: drawRect)
        color.set()
        UIRectFillUsingBlendMode(drawRect, .sourceAtop)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage!
    }
    
    func sw_scaledImage(with size: CGSize) -> UIImage {
        guard size != self.size else {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result!
    }
    
    func sw_scaledImage(withSmallerDimension minDimension: CGFloat) -> UIImage {
        var ratio: CGFloat
        if size.width > size.height {
            ratio = minDimension / size.height
        } else {
            ratio = minDimension / size.width
        }
        ratio = min(ratio, 1.0)
        
        return sw_scaledImage(with: CGSize(width: size.width * ratio, height: size.height * ratio))
    }
    
}
