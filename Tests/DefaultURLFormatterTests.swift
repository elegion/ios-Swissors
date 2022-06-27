//
//  Tests.swift
//  Tests
//
//  Created by Maxim Butin on 23.06.2022.
//

import XCTest
import Swissors

class DefaultURLFormatterTests: XCTestCase {
    
    func testDecodingAndEncodingDefaultURLFormmater() throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{"url": "https://www.google.com"}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixure.url, URL(string: "https://www.google.com"))
    }
    
    func testDecodingAndEncodingNilDefaultURLFormmater() throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixure.url, nil)
    }
    
    func testDecodingAndEncodingNoValidDefaultURLFormmater() throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{"url": true }"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixure.url, nil)
    }
}
