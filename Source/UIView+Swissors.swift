//
//  UIView+Swissors.swift
//  Swissors
//
//  Created by Sergey Rakov on 14.10.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: - Public
    
    static func sw_fullFrameConstraints(for superView: UIView, subview: UIView, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        if #available(iOS 9.0, *) {
            return [
                subview.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top),
                subview.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom),
                subview.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left),
                subview.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -insets.right),
            ]
        } else {
            return [NSLayoutConstraint(item: subview,
                                       attribute: .top,
                                       relatedBy: .equal,
                                       toItem: superView,
                                       attribute: .top,
                                       multiplier: 1.0,
                                       constant: insets.top),
                    
                    NSLayoutConstraint(item: subview,
                                       attribute: .left,
                                       relatedBy: .equal,
                                       toItem: superView,
                                       attribute: .left,
                                       multiplier: 1.0,
                                       constant: insets.left),
                    
                    NSLayoutConstraint(item: subview,
                                       attribute: .bottom,
                                       relatedBy: .equal,
                                       toItem: superView,
                                       attribute: .bottom,
                                       multiplier: 1.0,
                                       constant: -insets.bottom),
                    
                    NSLayoutConstraint(item: subview,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: superView,
                                       attribute: .right,
                                       multiplier: 1,
                                       constant: -insets.right),
            ]
        }
    }
    
    class func sw_viewFromNib(in bundle: Bundle = Bundle.main, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        return sw_viewFromNibHelper(in: bundle, owner: owner, options: options)
    }
    
    func sw_addSubview(_ subview: UIView, with constraints: [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }
    
    func sw_addSubviewWithFullFrameConstraints(_ subview: UIView,
                                               insetBy insets: UIEdgeInsets = .zero) {
        
        sw_addSubview(subview,
                      with: UIView.sw_fullFrameConstraints(for: self, subview: subview, with: insets))
    }
    
    func sw_insertSubview(_ subview: UIView,
                          at index: Int,
                          with constraints: [NSLayoutConstraint]) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(subview, at: index)
        NSLayoutConstraint.activate(constraints)
    }
    
    func sw_insertSubviewWithFullFrameConstraints(_ subview: UIView,
                                                  at index: Int,
                                                  insetBy insets: UIEdgeInsets = .zero) {
        
        sw_insertSubview(subview,
                         at: index,
                         with: UIView.sw_fullFrameConstraints(for: self, subview: subview, with: insets))
    }
    
    func sw_removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
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
    
    func sizeThatFitsWidth(_ width: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
    }
    
    func sizeThatFitsHeight(_ height: CGFloat) -> CGSize {
        return sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height))
    }

    // MARK: - Private
    
    private class func sw_viewFromNibHelper<T>(in bundle: Bundle, owner: Any?, options: [UINib.OptionsKey: Any]? = nil) -> T {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! T
    }
}
