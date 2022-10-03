//
//  DefaultEmptyStringTests.swift
//  SwissorsTests
//
//  Created by Alexander Rozhdestvenskiy on 03.10.2022.
//

import XCTest
import Swissors
import BetterCodable

// swiftlint:disable nesting
class DefaultEmptyStringTests: XCTestCase {
    
    func testDefaultEmptyStringCorrupted() throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, "")
    }
    
    func testDefaultEmptyString() throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{"name": "Alexander"}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, "Alexander")
    }
    
    func testDefaultEmptyStringNil() throws {
        
        struct Model: Codable {
            
            @DefaultEmptyString
            private(set) var name: String
        }
        
        let json = #"{"name": null}"#.data(using: .utf8)!
        let model = try JSONDecoder().decode(Model.self, from: json)
        XCTAssertEqual(model.name, "")
    }
    
}
