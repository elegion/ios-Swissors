//
//  UIViewAutoresizing+Swissors.swift
//  Swissors
//
//  Created by Evgeniy Akhmerov on 28/03/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import UIKit

public extension UIViewAutoresizing {
    
    public static var sw_flexibleMargins: UIViewAutoresizing {
        return [self.flexibleLeftMargin, self.flexibleTopMargin, self.flexibleRightMargin, self.flexibleBottomMargin]
    }
    
    public static var sw_flexibleSize: UIViewAutoresizing {
        return [self.flexibleWidth, self.flexibleHeight]
    }
}
