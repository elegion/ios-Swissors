//
//  NSRange+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension NSRange {
    
    public func sw_offset(by d: Int) -> NSRange {
        return NSRange(location: location + d, length: length)
    }
    
}
