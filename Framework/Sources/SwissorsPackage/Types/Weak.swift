//
//  Weak.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

public struct Weak<T: AnyObject> {
    
    public weak var value: T?
    
    public init(_ value: T) {
        self.value = value
    }
}
