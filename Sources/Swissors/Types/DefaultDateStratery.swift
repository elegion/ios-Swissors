//
//  DefaultDateStratery.swift
//  Swissors
//
//  Created by Maxim Butin on 22.06.2022.
//

import Foundation

public class DefaultDateStrategy: OptionalDateValueCodableStrategy {
    
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

public protocol OptionalDateValueCodableStrategy {
    
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> Date?
    static func encode(_ date: Date?) -> RawValue?
}

@propertyWrapper
public struct DateValue<Formatter: OptionalDateValueCodableStrategy>: Codable {
    
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
