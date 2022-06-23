//
//  DefaultURLStrategy.swift
//  Swissors
//
//  Created by Maxim Butin on 22.06.2022.
//

import Foundation

/// The default wrapper for the `DateValue` property, which allows you to encode and decode the URL.
public class DefaultURLCodableStrategy: URLCodableStrategy {
    
    public static func decode(_ value: String?) throws -> URL? {
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
