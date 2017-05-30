//
//  String+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension String {
    
    public func sw_byRemovingCharacters(from set: CharacterSet) -> String {
        return self.components(separatedBy: set).joined()
    }
    
}
