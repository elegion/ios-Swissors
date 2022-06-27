//
//  TimeZoneFormatter.swift
//  Swissors
//
//  Created by Maxim Butin on 27.06.2022.
//

import Foundation

public class TimZoneFormatter: DefaultDateFormatter {
    
    override class var formatter: DateFormatter {
        let formatter = DateFormatter.timeZoneFormat
        return formatter
    }
}
