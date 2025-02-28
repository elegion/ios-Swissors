//
//  File.swift
//  
//
//  Created by viktor.volkov on 25.08.2022.
//

import XCTest
import Swissors
import BetterCodable

// swiftlint:disable nesting
class DefaultNotEmptyStringTests: XCTestCase {
    
    func testDefaultNotEmptyStringCorrupted() throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, Model.X2ValueStrategy.defaultValue)
    }
    
    func testDefaultNotEmptyStringNil() throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{"name": null}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, Model.X2ValueStrategy.defaultValue)
    }
    
    func testDefaultNotEmptyStringEmpty() throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{"name": ""}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, Model.X2ValueStrategy.defaultValue)
    }
    
    func testDefaultNotEmptyStringDefault() throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        let json = #"{"name": "John Frum"}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, "John Frum")
    }
}
