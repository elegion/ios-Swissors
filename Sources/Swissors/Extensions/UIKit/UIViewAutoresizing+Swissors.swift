//
//  UIViewAutoresizing+Swissors.swift
//  Swissors
//
//  Created by Evgeniy Akhmerov on 28/03/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public extension UIView.AutoresizingMask {
    
    static let flexibleMargins: UIView.AutoresizingMask = {
        [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]
    }()
    
    static let flexibleSize: UIView.AutoresizingMask = {
        [.flexibleWidth, .flexibleHeight]
    }()
    
    // MARK: Deprecated methods
    @available(*, deprecated, renamed: "flexibleMargins")
    static let sw_flexibleMargins: UIView.AutoresizingMask = {
        flexibleMargins
    }()
    
    @available(*, deprecated, renamed: "flexibleSize")
    static let sw_flexibleSize: UIView.AutoresizingMask = {
        flexibleSize
    }()
}
