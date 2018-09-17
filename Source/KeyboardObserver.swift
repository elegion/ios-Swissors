//
//  KeyboardObserver.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public class KeyboardObserver {
    
    public typealias ObservationInfo = (beginFrame: CGRect, endFrame: CGRect, animationDuration: TimeInterval, curve: UIView.AnimationCurve, isLocal: Bool)
    public typealias ObservationClosure = (ObservationInfo) -> Void
    public typealias ObservationTuple = (owner: Weak<AnyObject>, handler: ObservationClosure)
    
    public static let shared = KeyboardObserver()
    
    var keyboardFrame: CGRect = .null
    
    fileprivate var observers: [ObservationTuple] = []
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onFrameChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    public func register(observer: AnyObject?, closure: @escaping ObservationClosure) {
        observers.append((Weak(observer ?? self), closure))
    }
    
    public func unregister(observer: AnyObject) {
        guard observer !== self else {
            return
        }
        
        observers = observers.filter { $0.owner.value != nil && $0.owner.value !== observer }
    }
    
    public func unregisterAll() {
        observers = []
    }
    
    @objc private func onFrameChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let beginFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveInt = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveInt) else {
                return
        }
        
        var isLocal: Bool? = nil
        if #available(iOS 9.0, *) {
            isLocal = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool
        }
        
        keyboardFrame = endFrame
        
        let info: ObservationInfo = (beginFrame, endFrame, animationDuration, curve, isLocal ?? true)
        notify(with: info)
    }
    
    private func cleanupObservers() {
        observers = observers.filter { $0.owner.value != nil }
    }
    
    private func notify(with info: ObservationInfo) {
        cleanupObservers()
        
        for observer in observers {
            observer.handler(info)
        }
    }
    
}

public extension KeyboardObserver {
    
    typealias HeightInfo = (height: CGFloat, animationDuration: TimeInterval, curve: UIView.AnimationCurve)
    
    private func keyboardHeight(for rect: CGRect) -> CGFloat {
        return UIScreen.main.bounds.height - rect.minY
    }
    
    public func registerForHeight(with owner: AnyObject? = nil, handler: @escaping (HeightInfo) -> Void) {
        register(observer: owner) {
            (info) in
            
            let result: HeightInfo
            result.height = self.keyboardHeight(for: info.endFrame)
            result.animationDuration = info.animationDuration
            result.curve = info.curve
            
            handler(result)
        }
    }
    
    public func register(with view: UIView, constraint: NSLayoutConstraint, constantAdjustment: CGFloat = 0.0, otherAnimatrions: (() -> Void)? = nil) {
        registerForHeight(with: view) {
            (info) in
            
            let option: UIView.AnimationOptions
            switch info.curve {
            case .easeIn:
                option = .curveEaseIn
            case .easeInOut:
                option = .curveEaseInOut
            case .easeOut:
                option = .curveEaseOut
            case .linear:
                option = .curveLinear
            }
            
            constraint.constant = info.height + constantAdjustment
            
            UIView.animate(withDuration: info.animationDuration, delay: 0.0, options: option, animations: {
                otherAnimatrions?()
                
                view.layoutIfNeeded()
            })
        }
    }
    
}
