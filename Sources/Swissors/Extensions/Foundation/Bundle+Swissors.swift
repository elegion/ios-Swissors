//
//  NSBundle+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import Foundation

public extension Bundle {
    
    subscript(key: String) -> Any? {
        guard let infoDictionary = infoDictionary else { return nil }
        return infoDictionary[key]
    }
    
    func infoDictionaryValue<T>(for key: String) -> T? {
        guard let infoDictionary = infoDictionary else { return nil }
        return infoDictionary[key] as? T
    }
    
    func infoDictionaryBool(for key: String, defaultValue: Bool = Bool()) -> Bool {
        guard let infoDictionary = infoDictionary else { return defaultValue }
        guard let value = infoDictionary[key] as? String else { return defaultValue }
        return Bool(value) ?? defaultValue
    }
    
    func decodeJSON<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }
        
        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: jsonData) else {
            fatalError("Failed to decode \(filename) from app bundle.")
        }
        
        return result
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "infoDictionaryValue")
    func sw_infoDictionaryValue<T>(for key: String) -> T? {
        infoDictionaryValue(for: key)
    }
    
    @available(*, deprecated, renamed: "decodeJSON")
    func sw_infoDictionaryBool(for key: String, defaultValue: Bool = Bool()) -> Bool {
        infoDictionaryBool(for: key, defaultValue: defaultValue)
    }
    
    @available(*, deprecated, renamed: "decodeJSON")
    func sw_decodeJSON<T: Decodable>(_ type: T.Type, from filename: String) -> T {
        decodeJSON(type, from: filename)
    }
}
