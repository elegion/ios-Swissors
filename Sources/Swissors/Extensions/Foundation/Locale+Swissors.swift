//
//  Locale+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/13/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension Locale {

    private enum Constants {
        static let russian = "ru_RU"
        static let enUS = "en_US"
        static let enUSPosix = "en_US_POSIX"
    }
    
    static let forPreferredLocalization = Bundle.main.preferredLocalizations.first.map(Locale.init)
    
    /// ru_RU
    static let russian = Locale(identifier: Constants.russian)
    
    /// en_US
    static let enUS = Locale(identifier: Constants.enUS)
    
    /// en_US_POSIX
    static let enPosix = Locale(identifier: Constants.enUSPosix)
}
