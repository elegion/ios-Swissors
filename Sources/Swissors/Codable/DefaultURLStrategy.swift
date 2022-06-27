//
//  DefaultURLStrategy.swift
//  Swissors
//
//  Created by Maxim Butin on 22.06.2022.
//

import Foundation

/// The default wrapper for the `DateValue` property, which allows you to encode and decode the URL.
public class DefaultURLCodableStrategy: URLCodableStrategy {
    
    public static func decode(_ value: String?) -> URL? {
        guard let value = value else {
            return nil
        }
        return URL(string: value)
    }
    
    public static func encode(_ url: URL?) -> String? {
        guard let url = url else {
            return nil
        }
        return url.absoluteString
    }
}

/// A protocol for providing a custom formatter for encoding and decoding dates.
///
/// `URLCodableStrategy` provides a generic formetter type that the `DateValue` property wrapper can use to inject
///  custom strategies for encoding and decoding URL values.
///

public protocol URLCodableStrategy {
    
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> URL?
    static func encode(_ url: URL?) -> RawValue?
}

@propertyWrapper
public struct URLValue<Formatter: URLCodableStrategy>: Codable {
    
    private let value: Formatter.RawValue?
    public var wrappedValue: URL?

    public init(wrappedValue: URL?) {
        self.wrappedValue = wrappedValue
        self.value = Formatter.encode(wrappedValue)
    }
    
    public init(from decoder: Decoder) throws {
        self.value = try? Formatter.RawValue(from: decoder)
        self.wrappedValue = try? Formatter.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

public extension KeyedDecodingContainer {

    func decode<P>(_: URLValue<P>.Type, forKey key: Key) throws -> URLValue<P> {
        if let value = try decodeIfPresent(URLValue<P>.self, forKey: key) {
            return value
        } else {
            return URLValue(wrappedValue: nil)
        }
    }
}
