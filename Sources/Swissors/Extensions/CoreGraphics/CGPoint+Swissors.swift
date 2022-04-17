//
//  CGPoint+Swissors.swift
//  Swissors
//
//  Created by viktor.volkov on 17.04.2022.
//

import CoreGraphics

public extension CGPoint {
    
    init(x: CGFloat) {
        self.init(x: x, y: .zero)
    }
    
    init(y: CGFloat) {
        self.init(x: .zero, y: y)
    }
    
    init(value: CGFloat) {
        self.init(x: value, y: value)
    }
}
