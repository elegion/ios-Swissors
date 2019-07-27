//
//  UIViewAutoresizing+Swissors.swift
//  Swissors
//
//  Created by Evgeniy Akhmerov on 28/03/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public extension UIView.AutoresizingMask {
    
    static var sw_flexibleMargins: UIView.AutoresizingMask {
        return [.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin]
    }
    
    static var sw_flexibleSize: UIView.AutoresizingMask {
        return [.flexibleWidth, .flexibleHeight]
    }
}
