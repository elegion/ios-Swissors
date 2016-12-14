//
//  UIColor+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension UIColor {
    
    public convenience init(hex: UInt32) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255;
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255;
        let b = CGFloat(hex & 0x0000FF) / 255;
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    public convenience init?(hexString: String) {
        assert(hexString.characters.count == 6)
        
        let scanner = Scanner(string: hexString)
        var result: UInt32 = 0
        if scanner.scanHexInt32(&result) == true {
            self.init(hex: result)
        } else {
            return nil
        }
    }
    
    public var sw_hex: String? {
        guard let colorSpace = cgColor.colorSpace?.model, let components = cgColor.components else {
            return nil
        }
        
        let r: CGFloat, g: CGFloat, b: CGFloat
        if colorSpace == .monochrome {
            r = components[0]
            g = components[0]
            b = components[0]
        } else {
            r = components[0]
            g = components[1]
            b = components[2]
        }
        
        return NSString(format: "%02lX%02lX%02lX", lround(Double(r) * 255), lround(Double(g) * 255), lround(Double(b) * 255)) as String
    }
    
    public func sw_blend(with color: UIColor, alpha: CGFloat) -> UIColor {
        let alpha = min(1, max(0, alpha))
        let beta = 1 - alpha
        
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var a1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var a2: CGFloat = 0
        
        getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r = r1 * beta + r2 * alpha
        let g = g1 * beta + g2 * alpha
        let b = b1 * beta + b2 * alpha
        let a = a1 * beta + a2 * alpha
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
}
