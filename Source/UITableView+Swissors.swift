//
//  UITableView+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 8/3/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public func sw_registerReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    
    public func sw_registerReusableCellNibOfType<T: UITableViewCell>(_ cellType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: String(describing: cellType), bundle: bundle)
        register(nib, forCellReuseIdentifier: String(describing: cellType))
    }
    
    public func sw_dequeueReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! T
    }
    
    public func sw_registerReusableHeaderFooterViewOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        register(viewType, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
    
    public func sw_registerHeaderFooterViewNibOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: String(describing: viewType), bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
    
    public func sw_dequeueReusableHeaderFooterViewOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as! T
    }
}
