//
//  UIViewController+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public typealias SWViewSetup = ((_ superView: UIView, _ subView: UIView) -> Void)?
    
    public func sw_addChildViewController(_ childViewController: UIViewController, viewSetup: SWViewSetup = nil) {
        addChild(childViewController)
        viewSetup?(view, childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    public func sw_removeFromParentViewController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
