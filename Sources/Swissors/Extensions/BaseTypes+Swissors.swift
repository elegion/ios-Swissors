//
//  BaseTypes+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}

public extension Int {
    var degreesToRadians: Double { Double(self).degreesToRadians }
    var radiansToDegrees: Double { Double(self).radiansToDegrees }
}
