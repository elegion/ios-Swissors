//
//  UIApplication+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    var topWindow: UIWindow? {
        windows.max(by: { $0.windowLevel < $1.windowLevel })
    }
    
    func presentViewController(_ viewController: UIViewController,
                               inNewWindowWithLevel windowLevel: UIWindow.Level,
                               animated: Bool = true,
                               setupHandler: ((UIWindow) -> Void)? = nil) {
        
        let emptyController = UIViewController()
        emptyController.definesPresentationContext = true
        emptyController.view.backgroundColor = UIColor.clear
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = emptyController
        window.windowLevel = windowLevel
        window.backgroundColor = UIColor.clear
        if let setupHandler = setupHandler {
            setupHandler(window)
        }
        window.makeKeyAndVisible()
        
        emptyController.present(viewController, animated: animated, completion: nil)
    }
    
    func openURL(_ url: URL, completionHandler completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            self.open(url, options: [:], completionHandler: completion)
        } else {
            let result = self.openURL(url)
            completion?(result)
        }
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "topWindow")
    func sw_topWindow() -> UIWindow? {
        topWindow
    }
    
    @available(*, deprecated, renamed: "presentViewController")
    func sw_presentViewController(_ viewController: UIViewController,
                                  inNewWindowWithLevel windowLevel: UIWindow.Level,
                                  animated: Bool = true,
                                  setupHandler: ((UIWindow) -> Void)? = nil) {
        presentViewController(viewController,
                              inNewWindowWithLevel: windowLevel,
                              animated: animated,
                              setupHandler: setupHandler)
    }
    
    @available(*, deprecated, renamed: "openURL")
    func sw_openURL(_ url: URL, completionHandler completion: ((Bool) -> Void)? = nil) {
        openURL(url, completionHandler: completion)
    }
}
