//
//  UIScreen+Swissors.swift
//  Swissors
//
//  Created by Роман Уваров on 05.05.2022.
//

import UIKit

extension UIScreen {
    
    static func topSafeAreaInset() -> CGFloat {
        let insets = getKeyWindow()?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.height
        return insets == .zero ? UIApplication.shared.statusBarFrame.height : insets
    }
    
    static func bottomSafeAreaInset() -> CGFloat {
        getKeyWindow()?.safeAreaInsets.bottom ?? .zero
    }
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let size = UIScreen.main.bounds.size
    
    private static func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
