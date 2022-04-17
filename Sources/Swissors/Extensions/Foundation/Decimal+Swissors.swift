//
//  Decimal+Swissors.swift
//  Swissors
//
//  Created by viktor.volkov on 17.04.2022.
//

import Foundation

public extension Decimal {
    
    var int: Int {
        NSDecimalNumber(decimal: self).intValue
    }
    
    var string: String {
        NSDecimalNumber(decimal: self).stringValue
    }
    
    var float: Float {
        NSDecimalNumber(decimal: self).floatValue
    }
    
    var double: Double {
         NSDecimalNumber(decimal: self).doubleValue
    }
}
