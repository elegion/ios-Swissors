//
//  ServerDateStrategy.swift
//  Swissors
//
//  Created by Maxim Butin on 27.06.2022.
//

import Foundation

public class ServerDataFormatter: DefaultDateFormatter {
    
    override class var formatter: DateFormatter {
        let formatter = DateFormatter.serverDateFormat
        return formatter
    }
}
