//
//  UIColor+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    
    convenience init(hex: UInt32) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255
        let b = CGFloat(hex & 0x0000FF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    convenience init?(hexString: String) {
        guard hexString.count == 6 else {
            return nil
        }
        
        let scanner = Scanner(string: hexString)
        var result: UInt32 = 0
        if scanner.scanHexInt32(&result) == true {
            self.init(hex: result)
        } else {
            return nil
        }
    }
    
    convenience init(absoluteRed red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(rgba: RGBA) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    convenience init(hexa: UInt64) {
        let r = CGFloat((hexa & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((hexa & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((hexa & 0x0000FF00) >> 8) / 255.0
        let a = CGFloat(hexa & 0x000000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init?(hexaString: String) {
        guard hexaString.count == 8 else {
            return nil
        }
        
        let scanner = Scanner(string: hexaString)
        var result: UInt64 = 0
        if scanner.scanHexInt64(&result) == true {
            self.init(hexa: result)
        } else {
            return nil
        }
    }
    
    var sw_rgba: RGBA {
        var result: RGBA = (0.0, 0.0, 0.0, 0.0)
        
        getRed(&(result.red), green: &(result.green), blue: &(result.blue), alpha: &(result.alpha))
        
        return result
    }
    
    var sw_hex: String? {
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
    
    func sw_blend(with color: UIColor, alpha: CGFloat) -> UIColor {
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
    
    func sw_intermediate(to other: UIColor, atPercent percent: CGFloat) -> UIColor {
        
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
