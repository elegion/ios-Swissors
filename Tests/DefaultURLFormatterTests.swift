//
//  Tests.swift
//  Tests
//
//  Created by Maxim Butin on 23.06.2022.
//

import Testing
import Foundation
import Swissors

struct DefaultURLFormatterTests {
    
	@Test
    func decodingAndEncodingDefaultURLFormmater() async throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{"url": "https://www.google.com"}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
		#expect(fixure.url == URL(string: "https://www.google.com"))
    }
    
	@Test
    func decodingAndEncodingNilDefaultURLFormmater() async throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
		#expect(fixure.url == nil)
    }
    
	@Test
    func decodingAndEncodingNoValidDefaultURLFormmater() async throws {
        struct Fixture: Codable {
            @URLValue<DefaultURLCodableStrategy> var url: URL?
        }
        let json = #"{"url": true }"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
		#expect(fixure.url == nil)
    }
}
