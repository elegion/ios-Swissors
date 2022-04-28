//
//  NSRange+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension NSRange {
    
    func offset(by d: Int) -> NSRange {
        NSRange(location: location + d, length: length)
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "offset")
    func sw_offset(by d: Int) -> NSRange {
        offset(by: d)
    }
}
