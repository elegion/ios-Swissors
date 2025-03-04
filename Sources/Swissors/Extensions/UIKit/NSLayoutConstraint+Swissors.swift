//
//  NSLayoutConstraint+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension NSLayoutConstraint {
    
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "with")
    func sw_with(priority: UILayoutPriority) -> NSLayoutConstraint {
        with(priority: priority)
    }
}
#endif
