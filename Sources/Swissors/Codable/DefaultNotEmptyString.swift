//
//  File.swift
//  
//
//  Created by viktor.volkov on 26.08.2022.
//

import Foundation
import BetterCodable

/// Позволяет декодировать `String` значением по умолчанию если значение не пришло или пришла пустая строка
///
/// Необходимо реализовать структуру, реализующую протокол `StringCodableStrategy`, где в `defaultValue`
/// необходимо вернуть значение по умолчанию
@propertyWrapper
public struct DefaultNotEmptyString<Default: StringCodableStrategy> {
    
    public var wrappedValue: String
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}

extension DefaultNotEmptyString: Decodable {
    
    public init(from decoder: Decoder) throws {
        if let nonNilString = try? Default.DefaultValue(from: decoder) {
            self.wrappedValue = nonNilString
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty ? Default.defaultValue : nonNilString
        } else {
            self.wrappedValue = Default.defaultValue
        }
    }
}

extension DefaultNotEmptyString: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

public protocol StringCodableStrategy: DefaultCodableStrategy where DefaultValue == String { }

extension DefaultNotEmptyString: Equatable where Default.DefaultValue: Equatable { }
extension DefaultNotEmptyString: Hashable where Default.DefaultValue: Hashable { }

public extension KeyedDecodingContainer {
    
    func decode<P: StringCodableStrategy>(_: DefaultNotEmptyString<P>.Type,
                                          forKey key: Key) throws -> DefaultNotEmptyString<P> {
        if let value = try decodeIfPresent(DefaultNotEmptyString<P>.self, forKey: key) {
            return value
        } else {
            return DefaultNotEmptyString(wrappedValue: P.defaultValue)
        }
    }
}
