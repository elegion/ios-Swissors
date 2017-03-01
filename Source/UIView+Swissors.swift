//
//  UIView+Swissors.swift
//  Swissors
//
//  Created by Sergey Rakov on 14.10.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIView {
    public class func sw_viewFromNib(in bundle: Bundle = Bundle.main, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> Self {
        return sw_viewFromNibHelper(in: bundle, owner: owner, options: options)
    }
    
    private class func sw_viewFromNibHelper<T>(in bundle: Bundle, owner: Any?, options: [AnyHashable : Any]? = nil) -> T {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! T
    }
    
    public func sw_addSubview(_ subview: UIView, with constraints:[NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }
    
    public static func sw_fullFrameConstraints(for superView: UIView, subView: UIView) -> [NSLayoutConstraint] {
        if #available(iOS 9.0, *) {
            return [subView.topAnchor.constraint(equalTo: superView.topAnchor),
                    subView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
                    subView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                    subView.trailingAnchor.constraint(equalTo: superView.trailingAnchor)]
        } else {
            return [NSLayoutConstraint(item: subView,
                    attribute: .top,
                    relatedBy: .equal,
                    toItem: superView,
                    attribute: .top,
                    multiplier: 1.0,
                    constant: 0),
                
                NSLayoutConstraint(item: subView,
                    attribute :.left,
                    relatedBy: .equal,
                    toItem: superView,
                    attribute: .left,
                    multiplier: 1.0,
                    constant: 0),
                
                NSLayoutConstraint(item: subView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: superView,
                    attribute: .bottom,
                    multiplier: 1.0,
                    constant: 0),
                
                NSLayoutConstraint(item: subView,
                    attribute: .right,
                    relatedBy: .equal,
                    toItem: superView,
                    attribute: .right,
                    multiplier: 1,
                    constant: 0)
                ]
        }
    }
    
    public func sw_setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = radius > 0
    }
}
