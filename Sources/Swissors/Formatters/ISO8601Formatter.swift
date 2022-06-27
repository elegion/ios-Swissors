//
//  ISO8601Formatter.swift
//  Swissors
//
//  Created by Maxim Butin on 27.06.2022.
//

import Foundation

public class ISO8601Formatter: DefaultDateFormatter {
    
    override class var formatter: DateFormatter {
        let formatter = DateFormatter.ISO8601Format
        return formatter
    }
}
