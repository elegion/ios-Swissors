//
//  Date+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension Date {
    
    var era: Int {
        component(.era)
    }
    
    var year: Int {
        component(.year)
    }
    
    var month: Int {
        component(.month)
    }
    
    var monthName: String {
        let names = Calendar.current.monthSymbols
        return names[month - 1]
    }
    
    var day: Int {
        component(.day)
    }
    
    var hour: Int {
        component(.hour)
    }
    
    var minute: Int {
        component(.minute)
    }
    
    var second: Int {
        component(.second)
    }
    
    var weekday: Int {
        component(.weekday)
    }
    
    var weekdayOrdinal: Int {
        component(.weekdayOrdinal)
    }
    
    var quarter: Int {
        component(.quarter)
    }
    
    var weekOfMonth: Int {
        component(.weekOfMonth)
    }
    
    var weekOfYear: Int {
        component(.weekOfYear)
    }
    
    var yearForWeekOfYear: Int {
        component(.yearForWeekOfYear)
    }
    
    var nanosecond: Int {
        component(.nanosecond)
    }
    
    var calendar: Int {
        component(.calendar)
    }
    
    var timeZone: Int {
        component(.timeZone)
    }
    
    func appending(eras: Int) -> Date? {
        appending(using: \.era, value: eras)
    }
    
    func appending(years: Int) -> Date? {
        appending(using: \.year, value: years)
    }
    
    func appending(months: Int) -> Date? {
        appending(using: \.month, value: months)
    }
    
    func appending(days: Int) -> Date? {
        appending(using: \.day, value: days)
    }
    
    func appending(hours: Int) -> Date? {
        appending(using: \.hour, value: hours)
    }
    
    func appending(minutes: Int) -> Date? {
        appending(using: \.minute, value: minutes)
    }
    
    func appending(seconds: Int) -> Date? {
        appending(using: \.second, value: seconds)
    }
    
    func appending(weekdays: Int) -> Date? {
        appending(using: \.weekday, value: weekdays)
    }
    
    func appending(weekdaysOrdinal: Int) -> Date? {
        appending(using: \.weekdayOrdinal, value: weekdaysOrdinal)
    }
    
    func appending(quarters: Int) -> Date? {
        appending(using: \.quarter, value: quarters)
    }
    
    func appending(weeksOfMonth: Int) -> Date? {
        appending(using: \.weekOfMonth, value: weeksOfMonth)
    }
    
    func appending(weeksOfYear: Int) -> Date? {
        appending(using: \.weekOfYear, value: weeksOfYear)
    }
    
    func appending(yearsForWeekOfYear: Int) -> Date? {
        appending(using: \.yearForWeekOfYear, value: yearsForWeekOfYear)
    }
    
    func appending(nanoseconds: Int) -> Date? {
        appending(using: \.nanosecond, value: nanoseconds)
    }
    
    func number(of unit: Calendar.Component,
                until date: Date,
                in calendar: Calendar = Calendar.current) -> Int {
        
        var fromDate = Date()
        var toDate = Date()
        var interval: TimeInterval = 0
        
        _ = calendar.dateInterval(of: unit, start: &fromDate, interval: &interval, for: self)
        _ = calendar.dateInterval(of: unit, start: &toDate, interval: &interval, for: date)
        
        let difference = calendar.dateComponents([unit], from: fromDate, to: toDate)
        return difference.value(for: unit) ?? -1
    }
    
    private func component(_ component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self)
    }
    
    private func appending(using path: WritableKeyPath<DateComponents, Int?>, value: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents[keyPath: path] = value
        return Calendar.current.date(byAdding: dateComponents, to: self)
    }
}
