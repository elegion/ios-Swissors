//
//  URL+Swissors.swift
//  Swissors
//
//  Created by Evgeniy Akhmerov on 23/03/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension URL {
    func sw_appendingQueryPair(_ pair: (key: String, value: String)) -> URL? {
        guard !self.isFileURL else { return nil }
        
        let separated = absoluteString.components(separatedBy: "?")
        let stringToAppend = pair.key + "=" + pair.value
        
        switch separated.count {
        case 1: return URL(string: [separated.first!, stringToAppend].joined(separator: "?"))
        case 2: return URL(string: [absoluteString, stringToAppend].joined(separator: "&"))
        default: return nil
        }
    }
}
