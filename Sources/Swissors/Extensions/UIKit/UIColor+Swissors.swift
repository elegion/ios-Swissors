//
//  UIColor+Extension.swift
//  ELNUtils
//
//  Created by Dmitry Nesterenko on 07/12/2016.
//  Copyright © 2016 e-legion. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIColor {
    
    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
    typealias HSLA = (hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat)
    
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
        var result: UInt32 = .zero
        if scanner.scanHexInt32(&result) == true {
            self.init(hex: result)
        } else {
            return nil
        }
    }
    
    convenience init(absoluteRed red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
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
    
    convenience init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat = 1) {
        let offset = saturation * (lightness < 0.5 ? lightness : 1 - lightness)
        let brightness = lightness + offset
        let saturation = lightness > .zero ? 2 * offset / brightness : .zero
        self.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    var rgba: RGBA {
        var result: RGBA = (.zero, .zero, .zero, .zero)
        getRed(&(result.red), green: &(result.green), blue: &(result.blue), alpha: &(result.alpha))
        
        return result
    }
    
    var hex: String? {
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
    
    var hsla: HSLA? {
        
        var (r, g, b): (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
        var (a, h): (CGFloat, CGFloat) = (.zero, .zero)
        guard
            getRed(&r, green: &g, blue: &b, alpha: &a),
            getHue(&h, saturation: nil, brightness: nil, alpha: nil)
        else {
            return nil
        }
        let upper = max(r, g, b)
        let lower = min(r, g, b)
        let range = upper - lower
        let lightness = (upper + lower) / 2
        let saturation = range == .zero
            ? .zero
            : range / (lightness < 0.5
                ? lightness * 2
                : 2 - lightness * 2)
        return (h, saturation, lightness, a)
    }
    
    func blend(with color: UIColor, alpha: CGFloat) -> UIColor {
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
    
    /// Вычисляет промежуточное значение цвета
    ///
    /// - Parameters:
    ///   - other: Конечный цвет
    ///   - percent: Процентное соотношение от 0 до 100
    func intermediate(to other: UIColor, atPercent percent: CGFloat) -> UIColor {
        
        func intermediate(from start: CGFloat, to end: CGFloat, by percent: CGFloat) -> CGFloat {
            start + (end - start) * percent
        }
        
        var newRGBA: RGBA
        let selfRGBA = rgba
        let otherRGBA = other.rgba
        let percentage = max(min(percent, 100), .zero) / 100
        switch percentage {
        case .zero:
            return self
        case 100:
            return other
        default:
            newRGBA.red = intermediate(from: selfRGBA.red, to: otherRGBA.red, by: percentage)
            newRGBA.green = intermediate(from: selfRGBA.green, to: otherRGBA.green, by: percentage)
            newRGBA.blue = intermediate(from: selfRGBA.blue, to: otherRGBA.blue, by: percentage)
            newRGBA.alpha = intermediate(from: selfRGBA.alpha, to: otherRGBA.alpha, by: percentage)
            return UIColor(rgba: newRGBA)
        }
    }
    
    /// Вычисляет промежуточное значение цветов
    ///
    /// - Parameters:
    ///   - from: Начальный цвет
    ///   - to: Конечный цвет
    ///   - percent: Процентное соотношение от 0 до 100
    static func intermediate(from fromColor: UIColor,
                             to toColor: UIColor,
                             percentage: CGFloat) -> UIColor {
        fromColor.intermediate(to: toColor, atPercent: percentage)
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "rgba")
    var sw_rgba: RGBA {
        rgba
    }
    
    @available(*, deprecated, renamed: "hex")
    var sw_hex: String? {
        hex
    }
    
    @available(*, deprecated, renamed: "blend")
    func sw_blend(with color: UIColor, alpha: CGFloat) -> UIColor {
        blend(with: color, alpha: alpha)
    }
    
    @available(*, deprecated, renamed: "intermediate")
    func sw_intermediate(to other: UIColor, atPercent percent: CGFloat) -> UIColor {
        intermediate(to: other, atPercent: percent)
    }
}

public extension CGColor {
    
    var uiColor: UIColor? {
        UIColor(cgColor: self)
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "uiColor")
    var sw_uiColor: UIColor? {
        uiColor
    }
}
#endif
