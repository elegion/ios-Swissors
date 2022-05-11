//
//  UIScreen+Swissors.swift
//  Swissors
//
//  Created by Роман Уваров on 05.05.2022.
//

import UIKit

extension UIScreen {
    
    static func topSafeAreaInset() -> CGFloat {
        let insets = UIApplication.shared.windows.first?.safeAreaInsets.top ?? UIApplication.shared.statusBarFrame.height
        return insets == .zero ? UIApplication.shared.statusBarFrame.height : insets
    }
    
    static func bottomSafeAreaInset() -> CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? .zero
    }
    
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let size = UIScreen.main.bounds.size
}
