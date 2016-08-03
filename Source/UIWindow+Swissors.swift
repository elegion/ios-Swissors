//
//  UIWindow+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    public class func fullScreenInstanceWithRootViewController(rootViewController: UIViewController) -> Self {
        let window = NSProcessInfo.processInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 9, minorVersion: 0, patchVersion: 0)) ? self.init() : self.init(frame: UIScreen.mainScreen().bounds)
        
        window.rootViewController = rootViewController;
        
        return window;
    }
}
