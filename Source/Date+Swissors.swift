//
//  Date+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension Date {
    
    static func ==(dateLeft: Date, dateRight: Date) -> Bool {
        return dateLeft.compare(dateRight) == ComparisonResult.orderedSame
    }
    
    func number(of unit: Calendar.Component, until date: Date, in calendar: Calendar = Calendar.current) -> Int {
        
        var fromDate: Date = Date(), toDate: Date = Date()
        var interval : TimeInterval = 0
        
        let _ = calendar.dateInterval(of: unit, start: &fromDate, interval: &interval, for: self)
        let _ = calendar.dateInterval(of: unit, start: &toDate, interval: &interval, for: date)
        
        let difference = calendar.dateComponents([unit], from: fromDate, to: toDate)
        return difference.value(for: unit) ?? -1
    }
}
