//
//  NSBundle+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension NSBundle {
    
    public subscript(key: String) -> AnyObject? {
        if let infoDictionary = infoDictionary {
            return infoDictionary[key]
        }
        
        return nil
    }
}
