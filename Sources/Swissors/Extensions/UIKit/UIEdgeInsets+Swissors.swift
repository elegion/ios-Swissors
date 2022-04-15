//
//  UIEdgeInsets+Swissors.swift
//  Swissors
//
//  Created by viktor.volkov on 15.04.2022.
//

import UIKit

public extension UIEdgeInsets {
    
    var inverted: UIEdgeInsets {
        UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }

    var horizontal: CGFloat {
        left + right
    }

    var vertical: CGFloat {
        top + bottom
    }

    init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }

    init(top: CGFloat) {
        self.init(top: top, other: .zero)
    }
    
    init(bottom: CGFloat) {
        self.init(bottom: bottom, other: .zero)
    }
    
    init(left: CGFloat) {
        self.init(left: left, other: .zero)
    }
    
    init(right: CGFloat) {
        self.init(right: right, other: .zero)
        self.init(top: .zero, left: .zero, bottom: .zero, right: right)
    }
    
    init(vertical: CGFloat) {
        self.init(vertical: vertical, horizontal: .zero)
    }

    init(horizontal: CGFloat) {
        self.init(vertical: .zero, horizontal: horizontal)
    }
    
    init(top: CGFloat, other: CGFloat) {
        self.init(top: top, left: other, bottom: other, right: other)
    }
    
    init(bottom: CGFloat, other: CGFloat) {
        self.init(top: other, left: other, bottom: bottom, right: other)
    }
    
    init(left: CGFloat, other: CGFloat) {
        self.init(top: other, left: left, bottom: other, right: other)
    }
    
    init(right: CGFloat, other: CGFloat) {
        self.init(top: other, left: other, bottom: other, right: right)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(rect: CGRect, applying size: CGSize) {
        let vertical = max(size.height - rect.height, .zero) / 2
        let horizontal = max(size.width - rect.width, .zero) / 2
        self.init(vertical: vertical, horizontal: horizontal)
    }
    
    init(top: CGFloat, bottom: CGFloat) {
        self.init(top: top, left: .zero, bottom: bottom, right: .zero)
    }

    init(top: CGFloat, horizontal: CGFloat) {
        self.init(top: top, left: horizontal, bottom: .zero, right: horizontal)
    }
    
    init(top: CGFloat, bottom: CGFloat, horizontal: CGFloat) {
        self.init(top: top, left: horizontal, bottom: bottom, right: horizontal)
    }

    init(bottom: CGFloat, horizontal: CGFloat) {
        self.init(top: .zero, left: horizontal, bottom: bottom, right: horizontal)
    }

    init(left: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: left, bottom: vertical, right: .zero)
    }
    
    init(left: CGFloat, right: CGFloat) {
        self.init(top: .zero, left: left, bottom: .zero, right: right)
    }

    init(right: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: .zero, bottom: vertical, right: right)
    }
}
