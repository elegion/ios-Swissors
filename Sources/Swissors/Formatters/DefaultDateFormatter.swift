//
//  DefaultDateFormatter.swift
//  Swissors
//
//  Created by Maxim Butin on 27.06.2022.
//

import Foundation

/// The default wrapper for the `OptionalDateValue` property, which allows you to encode and decode the date.
public class DefaultDateFormatter: OptionalDateValueCodableFormatter {
    
    class var formatter: DateFormatter {
        fatalError("should be override")
    }
    
    public static func decode(_ value: String?) throws -> Date? {
        guard let value = value else {
            return nil
        }
        return formatter.date(from: value)
    }
    
    public static func encode(_ date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        return formatter.string(from: date)
    }
}
