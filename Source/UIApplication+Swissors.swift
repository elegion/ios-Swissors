//
//  UIApplication+Swissors.swift
//  Swissors
//
//  Created by Георгий Касапиди on 03.08.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UIApplication {
    
    public func sw_topWindow() -> UIWindow? {
        return self.windows.sorted(by: { (w1, w2) -> Bool in
            return w1.windowLevel > w2.windowLevel
        }).first
    }
    
    public func sw_presentViewController(_ viewController: UIViewController, inNewWindowWithLevel windowLevel: UIWindowLevel, animated: Bool = true, setupHandler: ((UIWindow) -> Void)? = nil) {
        
        let emptyController = UIViewController()
        emptyController.definesPresentationContext = true
        emptyController.view.backgroundColor = UIColor.clear
        
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = emptyController;
        window.windowLevel = windowLevel
        window.backgroundColor = UIColor.clear
        if let setupHandler = setupHandler {
            setupHandler(window)
        }
        window.makeKeyAndVisible()
        
        emptyController.present(viewController, animated: animated, completion: nil)
    }
}
