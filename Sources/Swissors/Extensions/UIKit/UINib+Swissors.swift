//
//  UINib+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/31/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UINib {
    
    convenience init?(safeWithName name: String, bundle: Bundle = .main) {
        guard bundle.path(forResource: name, ofType: "nib") != nil else {
            return nil
        }
        
        self.init(nibName: name, bundle: bundle)
    }
}
#endif
