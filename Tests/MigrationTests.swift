//
//  File.swift
//  Swissors
//
//  Created by viktor.volkov on 28.02.2025.
//

import Testing
import Foundation
import Swissors

struct MigrationTests {
	
	@Test
	func stringValidatingInitializer() {
		let oldApiString = String(validatingUTF8: __dispatch_queue_get_label(nil))
		let newApiString = String(cString: __dispatch_queue_get_label(nil))
		#expect(oldApiString == newApiString)
	}
}
