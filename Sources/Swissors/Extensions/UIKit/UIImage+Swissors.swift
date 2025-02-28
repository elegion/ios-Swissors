//
//  UIImage+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, .zero)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func tintedImage(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let drawRect = CGRect(x: .zero, y: .zero, width: size.width, height: size.height)
        draw(in: drawRect)
        color.set()
        UIRectFillUsingBlendMode(drawRect, .sourceAtop)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    func scaledImage(with size: CGSize) -> UIImage {
        guard size != self.size else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
    
    func scaledImage(withSmallerDimension minDimension: CGFloat) -> UIImage {
        var ratio: CGFloat
        if size.width > size.height {
            ratio = minDimension / size.height
        } else {
            ratio = minDimension / size.width
        }
        ratio = min(ratio, 1)
        return scaledImage(with: CGSize(width: size.width * ratio, height: size.height * ratio))
    }
    
    class func image(with size: CGSize, drawing: (_ context: CGContext, _ rect: CGRect) -> Void) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let drawingRect = CGRect(origin: .zero, size: size)
        
        if let drawingContext = context {
            drawing(drawingContext, drawingRect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(with color: UIColor) -> UIImage? {
        let size = CGSize(width: 1.0, height: 1.0)
        return image(with: size) {
            _, rect in
            
            color.setFill()
            UIBezierPath(rect: rect).fill()
        }
    }
    
	@MainActor
    class func ovalImage(with size: CGSize, color: UIColor, fill: Bool) -> UIImage? {
        image(with: size) {
            _, rect in
            
            let px = 1.0 / UIScreen.main.scale
            
            let path = UIBezierPath(ovalIn: rect.insetBy(dx: px, dy: px))
            path.lineWidth = 1
            
            if fill {
                color.setFill()
                path.fill()
            } else {
                color.setStroke()
                path.stroke()
            }
        }
    }
    
    func alphaBlended(with color: UIColor) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        let rect = CGRect(origin: .zero, size: size)
        
        context?.setBlendMode(.normal)
        color.setFill()
        context?.fill(rect)
        
        context?.setBlendMode(.destinationIn)
        context?.draw(cgImage, in: rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "tintedImage")
    func sw_tintedImage(with color: UIColor) -> UIImage {
        tintedImage(with: color)
    }
    
    @available(*, deprecated, renamed: "scaledImage")
    func sw_scaledImage(with size: CGSize) -> UIImage {
        scaledImage(with: size)
    }
    
    @available(*, deprecated, renamed: "scaledImage")
    func sw_scaledImage(withSmallerDimension minDimension: CGFloat) -> UIImage {
        scaledImage(withSmallerDimension: minDimension)
    }
    
    @available(*, deprecated, renamed: "image")
    class func sw_image(with size: CGSize, drawing: (_ context: CGContext, _ rect: CGRect) -> Void) -> UIImage? {
        image(with: size, drawing: drawing)
    }
    
    @available(*, deprecated, renamed: "image")
    class func sw_image(with color: UIColor) -> UIImage? {
        image(with: color)
    }
    
    @available(*, deprecated, renamed: "ovalImage")
	@MainActor
    class func sw_ovalImage(with size: CGSize, color: UIColor, fill: Bool) -> UIImage? {
        ovalImage(with: size, color: color, fill: fill)
    }
    
    @available(*, deprecated, renamed: "alphaBlended")
    func sw_alphaBlended(with color: UIColor) -> UIImage? {
        alphaBlended(with: color)
    }
}
