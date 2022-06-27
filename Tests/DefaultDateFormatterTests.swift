//
//  DefaultDateFormatterTests.swift
//  SwissorsTests
//
//  Created by Maxim Butin on 23.06.2022.
//

import XCTest
import Swissors

// swiftlint:disable nesting
class ServerDateFormatterTests: XCTestCase {
    
    func testDecodingAndEncodingDefaultDateFormmater() throws {
        struct Fixture: Codable {
            @OptionalDateValue<ServerDataFormatter> var date: Date?
        }
        
        let json = #"{"date": "2022-06-16T11:33:52.786Z"}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        let date = try ServerDataFormatter.decode("2022-06-16T11:33:52.786Z")
        
        XCTAssertEqual(fixure.date, date)
    }
    
    func testDecodingAndEncodingNilDefaultDateFormmater() throws {
        struct Fixture: Codable {
            @OptionalDateValue<ServerDataFormatter> var date: Date?
        }
        let json = #"{}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixure.date, nil)
    }
    
    func testDecodingAndEncodingNoValidDefaultDateFormmater() throws {
        struct Fixture: Codable {
            @OptionalDateValue<ServerDataFormatter> var date: Date?
        }
        let json = #"{"date": 123}"#.data(using: .utf8)!
        
        let fixure = try JSONDecoder().decode(Fixture.self, from: json)
        XCTAssertEqual(fixure.date, nil)
    }
}

class ServerDataFormatter: DefaultDateFormatter {
    
    override class var formatter: DateFormatter {
        let formatter = DateFormatter.serverDateFormat
        return formatter
    }
}

extension DateFormatter {
    
    static let serverDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}
