//
//  DefaultURLStrategy.swift
//  Swissors
//
//  Created by Maxim Butin on 22.06.2022.
//

import Foundation

public protocol URLCodableStrategy {
    
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue?) throws -> URL?
    static func encode(_ url: URL?) -> String?
}

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
