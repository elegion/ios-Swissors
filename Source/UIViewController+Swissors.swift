//
//  UIViewController+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func sw_addSubViewController(_ subViewController: UIViewController, viewSetupClosure: ((_ superView: UIView, _ subView: UIView) -> Void)?) {
        self.addChildViewController(subViewController)
        
        
        self.addChildViewController(subViewController)
        viewSetupClosure?(self.view, subViewController.view)
        subViewController.didMove(toParentViewController: self)
    }
}
