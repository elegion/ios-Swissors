//
//  DefaultEmptyString.swift
//  Swissors
//
//  Created by Alexander Rozhdestvenskiy on 03.10.2022.
//

import Foundation
import BetterCodable

public struct DefaultEmptyStringStrategy: StringCodableStrategy {
    public static var defaultValue: String { return String() }
}

public typealias DefaultEmptyString = DefaultCodable<DefaultEmptyStringStrategy>
