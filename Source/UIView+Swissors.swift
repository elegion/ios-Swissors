//
//  UIView+Swissors.swift
//  Pods
//
//  Created by Evgeniy Akhmerov on 13/10/16.
//
//

import UIKit

public extension UIView {

    //  ???: any idea to avoid type passing
    public class func sw_viewFromNibType<T: UIView>(_ type: T.Type, bundle: Bundle? = .main, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T {
        let name = String(describing: T.self)
        let view = bundle?.loadNibNamed(name, owner: owner, options: options)?.first
        return view as! T
    }
}
