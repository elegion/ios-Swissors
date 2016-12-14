//
//  UIWindow+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    public func sw_changeRootViewControllerTo(_ viewController: UIViewController, withTransitionStyle transitionStyle: UIViewAnimationOptions = .transitionCrossDissolve, duration: TimeInterval = CATransaction.animationDuration()) {
        if rootViewController == nil || transitionStyle == UIViewAnimationOptions() {
            rootViewController = viewController
            
            return
        }
        
        let snapshot = rootViewController!.view.snapshotView(afterScreenUpdates: false)
        
        if let snapshot = snapshot {
            viewController.view.addSubview(snapshot)
        }
        
        rootViewController = viewController
        
        UIView.transition(with: self, duration: duration, options: transitionStyle, animations: {
            snapshot?.removeFromSuperview()
        }, completion: nil)
    }
}
