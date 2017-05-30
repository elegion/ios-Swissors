//
//  UIColor+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation

public extension UIColor {
    
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
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
    
    public convenience init(absoluteRed red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    public convenience init(rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    public var sw_rgba: RGBA {
        var result: RGBA = (0.0, 0.0, 0.0, 0.0)
        
        getRed(&(result.red), green: &(result.green), blue: &(result.blue), alpha: &(result.alpha))
        
        return result
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
    
    public func sw_intermediate(to other: UIColor, atPercent percent: CGFloat) -> UIColor {
        
        let selfRGBA = sw_rgba
        let otherRGBA = other.sw_rgba
        
        func intermediate(from start: CGFloat, to end: CGFloat, by percent: CGFloat) -> CGFloat {
            return start + (end - start) * percent
        }
        
        var newRGBA: RGBA
        
        newRGBA.red = intermediate(from: selfRGBA.red, to: otherRGBA.red, by: percent)
        newRGBA.green = intermediate(from: selfRGBA.green, to: otherRGBA.green, by: percent)
        newRGBA.blue = intermediate(from: selfRGBA.blue, to: otherRGBA.blue, by: percent)
        newRGBA.alpha = intermediate(from: selfRGBA.alpha, to: otherRGBA.alpha, by: percent)
        
        return UIColor(rgba: newRGBA)
    }
    
}

public extension CGColor {
    
    var sw_uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
    
}
