//
//  DefaultEmptyStringTests.swift
//  SwissorsTests
//
//  Created by Alexander Rozhdestvenskiy on 03.10.2022.
//

import Swissors
import Foundation
import Testing
import BetterCodable

// swiftlint:disable nesting
struct DefaultEmptyStringTests {
    
	@Test
    func defaultEmptyStringCorrupted() async throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == "")
    }
    
	@Test
    func defaultEmptyString() async throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{"name": "Alexander"}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == "Alexander")
    }
    
	@Test
    func defaultEmptyStringNil() async throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{"name": null}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
		#expect(model.name == "")
    }
    
}
