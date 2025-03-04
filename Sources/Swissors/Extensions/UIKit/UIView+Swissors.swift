//
//  UIView+Swissors.swift
//  Swissors
//
//  Created by Sergey Rakov on 14.10.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    
    // MARK: - Public
    
    static func fullFrameConstraints(for superView: UIView, subview: UIView, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
		return [
			subview.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top),
			subview.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom),
			subview.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: insets.left),
			subview.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -insets.right),
		]
    }
    
    class func viewFromNib(in bundle: Bundle = Bundle.main, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        viewFromNibHelper(in: bundle, owner: owner, options: options)
    }
    
    var descendantFirstResponder: UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let responder = subview.descendantFirstResponder {
                return responder
            }
        }
        return nil
    }
    
    func addSubview(_ subview: UIView, with constraints: [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(constraints)
    }
    
    func addSubviewWithFullFrameConstraints(_ subview: UIView,
                                            insetBy insets: UIEdgeInsets = .zero) {
        
        addSubview(subview,
                   with: UIView.fullFrameConstraints(for: self, subview: subview, with: insets))
    }
    
    func insertSubview(_ subview: UIView,
                       at index: Int,
                       with constraints: [NSLayoutConstraint]) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(subview, at: index)
        NSLayoutConstraint.activate(constraints)
    }
    
    func insertSubviewWithFullFrameConstraints(_ subview: UIView,
                                               at index: Int,
                                               insetBy insets: UIEdgeInsets = .zero) {
        
        insertSubview(subview,
                      at: index,
                      with: UIView.fullFrameConstraints(for: self, subview: subview, with: insets))
    }
    
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func round(corners: UIRectCorner, with radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    func descendants<TC: UIView>(of targetClass: TC.Type, avoiding avoidedViews: [UIView.Type] = []) -> [TC] {
        
        guard avoidedViews.first(where: { isKind(of: $0) }) == nil else {
            return []
        }
        
        var result: [TC] = []
        
        if isKind(of: targetClass) {
            result.append(self as! TC) // swiftlint:disable:this force_cast
        }
        
        for view in subviews {
            result.append(contentsOf: view.descendants(of: targetClass, avoiding: avoidedViews))
        }
        
        return result
    }
    
    func sizeThatFitsWidth(_ width: CGFloat) -> CGSize {
        sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
    }
    
    func sizeThatFitsHeight(_ height: CGFloat) -> CGSize {
        sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: height))
    }
    
    // MARK: - Private
    
    private class func viewFromNibHelper<T>(in bundle: Bundle, owner: Any?, options: [UINib.OptionsKey: Any]? = nil) -> T {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! T // swiftlint:disable:this force_cast
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "descendantFirstResponder")
    var sw_descendantFirstResponder: UIView? {
        descendantFirstResponder
    }
    
    @available(*, deprecated, renamed: "fullFrameConstraints")
    static func sw_fullFrameConstraints(for superView: UIView, subview: UIView, with insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        fullFrameConstraints(for: superView, subview: subview, with: insets)
    }
    
    @available(*, deprecated, renamed: "viewFromNib")
    class func sw_viewFromNib(in bundle: Bundle = Bundle.main, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self {
        viewFromNib(in: bundle, owner: owner, options: options)
    }
    
    @available(*, deprecated, renamed: "addSubview")
    func sw_addSubview(_ subview: UIView, with constraints: [NSLayoutConstraint]) {
        addSubview(subview, with: constraints)
    }
    
    @available(*, deprecated, renamed: "addSubviewWithFullFrameConstraints")
    func sw_addSubviewWithFullFrameConstraints(_ subview: UIView,
                                               insetBy insets: UIEdgeInsets = .zero) {
        addSubviewWithFullFrameConstraints(subview, insetBy: insets)
    }
    
    @available(*, deprecated, renamed: "insertSubview")
    func sw_insertSubview(_ subview: UIView,
                          at index: Int,
                          with constraints: [NSLayoutConstraint]) {
        insertSubview(subview, at: index, with: constraints)
    }
    
    @available(*, deprecated, renamed: "insertSubviewWithFullFrameConstraints")
    func sw_insertSubviewWithFullFrameConstraints(_ subview: UIView,
                                                  at index: Int,
                                                  insetBy insets: UIEdgeInsets = .zero) {
        insertSubviewWithFullFrameConstraints(subview, at: index, insetBy: insets)
    }
    
    @available(*, deprecated, renamed: "removeAllSubviews")
    func sw_removeAllSubviews() {
        removeAllSubviews()
    }
    
    @available(*, deprecated, renamed: "round")
    func sw_round(corners: UIRectCorner, with radius: CGFloat) {
        round(corners: corners, with: radius)
    }
    
    @available(*, deprecated, renamed: "descendants")
    func sw_descendants<TC: UIView>(of targetClass: TC.Type, avoiding avoidedViews: [UIView.Type] = []) -> [TC] {
        descendants(of: targetClass, avoiding: avoidedViews)
    }
}
#endif
