//
//  DefaultDateStratery.swift
//  Swissors
//
//  Created by Maxim Butin on 22.06.2022.
//

import Foundation

/// The default wrapper for the `DateValue` property, which allows you to encode and decode the date.
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

/// A protocol for providing a custom formatter for encoding and decoding dates.
///
/// `OptionalDateValueCodableFormatter` provides a generic formetter type that the `DateValue` property wrapper can use to inject
///  custom strategies for encoding and decoding date values.
///
///  The difference between this formatter and the formatter from BetterCodable is the ability to work with optional data types.
public protocol OptionalDateValueCodableFormatter {
    
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> Date?
    static func encode(_ date: Date?) -> RawValue?
}

/// Decodes and encodes dates using a strategy type.
///
/// `@DateValue` decodes dates using a `OptionalDateValueCodableFormatter` which provides custom decoding and encoding functionality.
@propertyWrapper
public struct DateValue<Formatter: OptionalDateValueCodableFormatter>: Codable {
    
    private let value: Formatter.RawValue?
    public var wrappedValue: Date?

    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        self.value = Formatter.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.value = try Formatter.RawValue(from: decoder)
        self.wrappedValue = try Formatter.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

public extension KeyedDecodingContainer {

    func decode<P>(_: DateValue<P>.Type, forKey key: Key) throws -> DateValue<P> {
        if let value = try decodeIfPresent(DateValue<P>.self, forKey: key) {
            return value
        } else {
            return DateValue(wrappedValue: nil)
        }
    }
}
