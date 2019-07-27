//
//  Dictionary+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension Dictionary {
 
    mutating func addValues(from dictionary: Dictionary<Key, Value>) {
        for element in dictionary {
            self[element.key] = element.value
        }
    }
    
    func dictionaryByAddingValues(from dictionary: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var result = self
        
        result.addValues(from: dictionary)
        
        return result
    }
    
}
