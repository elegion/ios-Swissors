//
//  UIView+Swissors.swift
//  Swissors
//
//  Created by Sergey Rakov on 14.10.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - Public
    
    static func sw_fullFrameConstraints(for superView: UIView, subView: UIView) -> [NSLayoutConstraint] {
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
    
    class func sw_viewFromNib(in bundle: Bundle = Bundle.main, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        return sw_viewFromNibHelper(in: bundle, owner: owner, options: options)
    }
    
    func sw_addSubview(_ subview: UIView, with constraints:[NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }
    
    func sw_round(corners: UIRectCorner, with radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        
        layer.mask = shapeLayer
    }
    
    func sw_descendants<TC: UIView>(of targetClass: TC.Type, avoiding avoidedViews: [UIView.Type] = []) -> [TC] {
        
        guard avoidedViews.first(where: { self.isKind(of: $0) }) == nil else {
            return []
        }
        
        var result: [TC] = []
        
        if self.isKind(of: targetClass) {
            result.append(self as! TC)
        }
        
        for view in self.subviews {
            result.append(contentsOf: view.sw_descendants(of: targetClass, avoiding: avoidedViews))
        }
        
        return result
    }
    
    var sw_descendantFirstResponder: UIView? {
        
        if self.isFirstResponder {
            return self
        }
        
        for subview in subviews {
            if let responder = subview.sw_descendantFirstResponder {
                return responder
            }
        }
        
        return nil
    }
    
    //MARK: - Private
    
    private class func sw_viewFromNibHelper<T>(in bundle: Bundle, owner: Any?, options: [UINib.OptionsKey: Any]? = nil) -> T {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! T
    }
}
