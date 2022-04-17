//
//  CGRect.swift
//  Swissors
//
//  Created by viktor.volkov on 17.04.2022.
//

import CoreGraphics

public extension CGRect {
    
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
}
