//
//  File.swift
//  
//
//  Created by viktor.volkov on 25.08.2022.
//

import Testing
import Foundation
import Swissors
import BetterCodable

// swiftlint:disable nesting
struct DefaultNotEmptyStringTests {
    
	@Test
    func defaultNotEmptyStringCorrupted() async throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == Model.X2ValueStrategy.defaultValue)
    }
    
	@Test
    func defaultNotEmptyStringNil() async throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{"name": null}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == Model.X2ValueStrategy.defaultValue)
    }
    
	@Test
    func defaultNotEmptyStringEmpty() async throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        
        let json = #"{"name": ""}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == Model.X2ValueStrategy.defaultValue)
    }
    
	@Test
    func defaultNotEmptyStringDefault() async throws {
        
        struct Model: Codable {
            struct X2ValueStrategy: StringCodableStrategy {
                static let defaultValue: String = "x2"
            }
            
            @DefaultNotEmptyString<X2ValueStrategy>
            private(set) var name: String
        }
        let json = #"{"name": "John Frum"}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == "John Frum")
    }
}
