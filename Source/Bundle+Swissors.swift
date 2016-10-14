//
//  NSBundle+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension Bundle {
    
    public subscript(key: String) -> AnyObject? {
        guard let infoDictionary = infoDictionary else { return nil }
        return infoDictionary[key] as AnyObject?
    }
    
    public func sw_infoDictionaryStringForKey(_ key: String) -> String? {
        guard let infoDictionary = infoDictionary else { return nil }
        return infoDictionary[key] as! String?
    }
    
    public func sw_infoDictionaryBoolForKey(_ key: String) -> Bool {
        guard let infoDictionary = infoDictionary else { return false }
        guard let value = infoDictionary[key] as? String else { return false }
        return Bool(value) == true
    }
}
