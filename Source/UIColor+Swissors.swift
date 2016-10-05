//
//  UIColor+Swissors.swift
//  Swissors
//
//  Created by Evgeniy Akhmerov on 04/10/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public class func colorWith(hexMask: UInt) -> UIColor {
        let r = (hexMask & 0xFF0000) >> 16
        let g = (hexMask & 0x00FF00) >> 8
        let b = (hexMask & 0x0000FF)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
}
