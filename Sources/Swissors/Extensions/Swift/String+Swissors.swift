//
//  String+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension String {
    
    var int: Int? {
        Int(self)
    }
    
    var digits: String {
        byRemovingCharacters(from: .decimalDigits.inverted)
    }
    
    var wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(startIndex..<endIndex, in: self)) ?? .zero
    }
    
    func byRemovingCharacters(from set: CharacterSet) -> String {
        components(separatedBy: set).joined()
    }
    
    func nsRange(of value: String) -> NSRange? {
        guard let range = range(of: value) else {
            return nil
        }
        return NSRange(range, in: self)
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "byRemovingCharacters")
    func sw_byRemovingCharacters(from set: CharacterSet) -> String {
        byRemovingCharacters(from: set)
    }
    
    @available(*, deprecated, renamed: "wordCount")
    var sw_wordCount: Int {
        wordCount
    }
}
