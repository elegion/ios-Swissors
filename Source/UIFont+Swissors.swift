//
//  UIFont+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 03.04.17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

extension UIFont {

    @available(iOS 8.2, *)
    enum FontWeight: RawRepresentable {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black

        typealias RawValue = CGFloat

        var rawValue: CGFloat {
            switch self {
            case .ultraLight: return UIFontWeightUltraLight
            case .thin: return UIFontWeightThin
            case .light: return UIFontWeightLight
            case .regular: return UIFontWeightRegular
            case .medium: return UIFontWeightMedium
            case .semibold: return UIFontWeightSemibold
            case .bold: return UIFontWeightBold
            case .heavy: return UIFontWeightHeavy
            case .black: return UIFontWeightBlack
            }
        }

        init?(rawValue: CGFloat) {
            switch rawValue {
            case UIFontWeightUltraLight:
                self = .ultraLight
            case UIFontWeightThin:
                self = .thin
            case UIFontWeightLight:
                self = .light
            case UIFontWeightRegular:
                self = .regular
            case UIFontWeightMedium:
                self = .medium
            case UIFontWeightSemibold:
                self = .semibold
            case UIFontWeightBold:
                self = .bold
            case UIFontWeightHeavy:
                self = .heavy
            case UIFontWeightBlack:
                self = .black
            default:
                self = .regular
            }
        }
    }

    @available(iOS 8.2, *)
    static func sw_font(ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        return systemFont(ofSize: size, weight: weight.rawValue)
    }

    func sw_sizeOfString(_ string: String, constrainedToWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = string.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: self], context: nil)

        return boundingBox.size
    }
}
