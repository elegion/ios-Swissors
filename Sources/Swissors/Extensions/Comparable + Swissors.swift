//
//  Comparable + Swissors.swift
//  Swissors
//
//  Created by Maxim Kotelevsky  on 1/27/20.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

public extension Comparable {
    
    func sw_bounded(_ low: Self, _ high: Self) -> Self {
        return max(low, min(high, self))
    }
}
