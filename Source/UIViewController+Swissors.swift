//
//  UIViewController+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func addSubViewController(_ subViewController: UIViewController, viewSetupClosure: ((_ superView: UIView, _ subView: UIView) -> Void)?) {
        self.addChildViewController(subViewController)
        
        if let viewSetupClosure = viewSetupClosure {
            viewSetupClosure(self.view, subViewController.view)
        }
        
        subViewController.didMove(toParentViewController: self)
    }
    
    public func autoAddSubViewController(_ subViewController: UIViewController, constraintsSetupClosure: @escaping (_ superView: UIView, _ subView: UIView) -> [NSLayoutConstraint]) {
        addSubViewController(subViewController) { (superView, subView) in
            superView.addSubview(subView)
            
            subView.autoresizingMask = UIViewAutoresizing()
            subView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(constraintsSetupClosure(superView, subView))
        }
    }
}
