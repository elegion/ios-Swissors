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
    
    public func sw_addSubViewController(_ subViewController: UIViewController, viewSetup: SWViewSetup = nil) {
        
        self.addChildViewController(subViewController)
        viewSetup?(self.view, subViewController.view)
        subViewController.didMove(toParentViewController: self)
    }
}
