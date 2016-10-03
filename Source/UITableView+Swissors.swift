//
//  UITableView+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 8/3/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public func registerReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    
    public func registerReusableCellNibOfType<T: UITableViewCell>(_ cellType: T.Type, bundle: Bundle?) {
        let nib = UINib(nibName: String(describing: cellType), bundle: bundle)
        register(nib, forCellReuseIdentifier: String(describing: cellType))
    }
    
    public func dequeueReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! T
    }
}
