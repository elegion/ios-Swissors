//
//  Comparable + Swissors.swift
//  Swissors
//
//  Created by Maxim Kotelevsky  on 1/27/20.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

public extension Comparable {
    
    func dw_closestValueWithinBounds(low: Self, high: Self) -> Self {
        if (self > high) {
            return high
        } else if (self < low) {
            return low
        }
        
        return self
    }
}
