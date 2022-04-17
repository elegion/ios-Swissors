//
//  FloatingPoint.swift
//  Swissors
//
//  Created by viktor.volkov on 17.04.2022.
//

public extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}
