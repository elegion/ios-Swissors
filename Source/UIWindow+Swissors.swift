//
//  UIWindow+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 14.12.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIWindow {

    public static var mainScreenKeyedVisible: UIWindow {
        let w = UIWindow(frame: UIScreen.main.bounds)
        w.makeKeyAndVisible()
        return w
    }
    
    public enum RootViewControllerTransitionAnimation {
        
        case none
        
        case flipFromLeft
        
        case flipFromRight
        
        case curlUp
        
        case curlDown
        
        case crossDissolve
        
        case flipFromTop
        
        case flipFromBottom
        
        var animationOptions: UIViewAnimationOptions {
            var options: UIViewAnimationOptions = [.allowAnimatedContent]
            switch self {
            case .none:
                ()
            case .flipFromLeft:
                options.formUnion(.transitionFlipFromLeft)
            case .flipFromRight:
                options.formUnion(.transitionFlipFromRight)
            case .curlUp:
                options.formUnion(.transitionCurlUp)
            case .curlDown:
                options.formUnion(.transitionCurlDown)
            case .crossDissolve:
                options.formUnion(.transitionCrossDissolve)
            case .flipFromTop:
                options.formUnion(.transitionFlipFromTop)
            case .flipFromBottom:
                options.formUnion(.transitionFlipFromBottom)
            }
            return options
        }
        
        var isAnimated: Bool {
            return self != .none
        }
        
    }
    
    /**
     Replaces root view controller with specified animation.
     Often used by the auth <-> main screens transition.
     */
    public func sw_replaceRootViewController(with viewController: UIViewController, animation: RootViewControllerTransitionAnimation, completion: @escaping (Bool) -> Void) {
        guard let rootViewController = rootViewController, rootViewController.isViewLoaded, rootViewController.view.layer.presentation() != nil else {
            self.rootViewController = viewController
            return
        }
        
        let completion_: (Bool) -> Void = { finished in
            // dismiss any previously presented modal view controllers
            if rootViewController.presentedViewController != nil {
                self.sw_dismissPresentedViewControllers(for: rootViewController, completion: {
                    rootViewController.view.removeFromSuperview()
                    completion(finished)
                })
            } else {
                completion(finished)
            }
        }
        
        if animation.isAnimated, let rootViewControllerView = rootViewController.view.snapshotView(afterScreenUpdates: false) {
            self.rootViewController = rootViewController
            self.rootViewController?.view.addSubview(rootViewControllerView)
            UIView.transition(with: self, duration: 0.33, options: animation.animationOptions, animations: {
                rootViewControllerView.removeFromSuperview()
            }, completion: completion_)
        } else {
            self.rootViewController = viewController
            completion_(true)
        }
    }
    
    private func sw_dismissPresentedViewControllers(for viewController: UIViewController, completion: (() -> ())? = nil) {
        guard viewController.presentedViewController != nil else {
            completion?()
            return
        }
        
        viewController.dismiss(animated: false) { [weak self, weak viewController] in
            guard let viewController = viewController else {
                return
            }
            
            self?.sw_dismissPresentedViewControllers(for: viewController, completion: completion)
        }
    }
}
