//
//  UITableView+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 8/3/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

extension UITableView {
    
    public func registerReusableCellOfType<T: UITableViewCell>(cellType: T.Type) {
        registerClass(cellType, forCellReuseIdentifier: String(cellType))
    }
    
    public func registaerReusableCellNibOfType<T: UITableViewCell>(cellType: T.Type, bundle: NSBundle?) {
        let nib = UINib(nibName: String(cellType), bundle: bundle)
        
        registerNib(nib, forCellReuseIdentifier: String(cellType))
    }
    
    public func dequeueReusableCellOfType<T: UITableViewCell>(cellType: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithIdentifier(String(cellType), forIndexPath: indexPath) as! T
    }
}
