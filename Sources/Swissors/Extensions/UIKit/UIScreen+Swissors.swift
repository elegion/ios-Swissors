//
//  UIScreen+Swissors.swift
//  Swissors
//
//  Created by Роман Уваров on 05.05.2022.
//

import UIKit

extension UIScreen {
    
    static func topSafeAreaInset() -> CGFloat {
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.height
        return insets == .zero ? UIApplication.shared.statusBarFrame.height : insets
    }
    
    static func bottomSafeAreaInset() -> CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.height
    static var size = UIScreen.main.bounds.size
}
