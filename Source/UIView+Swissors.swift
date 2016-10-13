//
//  UIView+Swissors.swift
//  Swissors
//
//  Created by Sergey Rakov on 14.10.16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

extension UIView {
    class func sw_viewFromNib(bundle: Bundle = Bundle.main, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> Self? {
        return sw_viewFromNibHelper(bundle: bundle, owner: owner, options: options)
    }
    
    private class func sw_viewFromNibHelper<T>(bundle: Bundle, owner: Any?, options: [AnyHashable : Any]?) -> T {
        let className = String(describing: self)
        let nib = UINib(nibName: className, bundle: bundle)
        return nib.instantiate(withOwner: owner, options: options).first as! T
    }
}
