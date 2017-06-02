//
//  UIFont+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/2/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

@available(iOS 8.2, *)
public extension UIFont {
    
    public struct Weight: RawRepresentable {
        public var rawValue: CGFloat
        
        public init(rawValue: CGFloat) {
            self.rawValue = rawValue
        }
        
        static let ultraLight  = Weight(rawValue: UIFontWeightUltraLight)
        static let thin        = Weight(rawValue: UIFontWeightThin)
        static let light       = Weight(rawValue: UIFontWeightLight)
        static let regular     = Weight(rawValue: UIFontWeightRegular)
        static let medium      = Weight(rawValue: UIFontWeightMedium)
        static let semibold    = Weight(rawValue: UIFontWeightSemibold)
        static let bold        = Weight(rawValue: UIFontWeightBold)
        static let heavy       = Weight(rawValue: UIFontWeightHeavy)
        static let black       = Weight(rawValue: UIFontWeightBlack)
    }
    
    public class func sw_systemFont(ofSize size: CGFloat, weight: Weight) -> UIFont {
        return self.systemFont(ofSize: size, weight: weight.rawValue)
    }
    
}
