//
//  Date+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension Date {
    public func isEqual(to date: Date) -> Bool {
        return compare(date) == ComparisonResult.orderedSame
    }
    
    public func numberOfUnits(until date: Date, calendarUnit: Calendar.Component, inTimeZone timeZone: TimeZone? = nil) -> Int {
        var calendar = Calendar.current
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        } else {
            calendar.timeZone = TimeZone.autoupdatingCurrent
        }
        
        var fromDate: Date = Date(), toDate: Date = Date()
        var interval : TimeInterval = 0
        
        let _ = calendar.dateInterval(of: calendarUnit, start: &fromDate, interval: &interval, for: self)
        let _ = calendar.dateInterval(of: calendarUnit, start: &toDate, interval: &interval, for: date)
        
        let difference = calendar.dateComponents([calendarUnit], from: fromDate, to: toDate)
        return difference.value(for: calendarUnit) ?? -1
    }
}
