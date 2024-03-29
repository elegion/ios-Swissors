//
//  Collection+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

public extension Collection {
    
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    func categorize<Category: Hashable>(where categorize: (Iterator.Element) throws -> Category) rethrows -> [Category: [Iterator.Element]] {
        var result: [Category: [Iterator.Element]] = [:]
        
        for element in self {
            let category = try categorize(element)
            
            if var categoryResult = result[category] {
                categoryResult.append(element)
                result[category] = categoryResult
            } else {
                result[category] = [element]
            }
        }
        return result
    }
}
