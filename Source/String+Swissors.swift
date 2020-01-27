//
//  String+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension String {
    
    func sw_byRemovingCharacters(from set: CharacterSet) -> String {
        return self.components(separatedBy: set).joined()
    }
    
    var sw_wordCount: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+")
        return regex?.numberOfMatches(in: self, range: NSRange(self.startIndex..<self.endIndex, in: self)) ?? 0
    }
}
