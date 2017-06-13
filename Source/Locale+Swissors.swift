//
//  Locale+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/13/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension Locale {

    public static var forPreferredLocalization: Locale? {
        return Bundle.main.preferredLocalizations.first.map(Locale.init)
    }

}
