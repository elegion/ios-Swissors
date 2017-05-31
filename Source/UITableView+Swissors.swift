//
//  UITableView+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 8/3/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func sw_register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if tryNib, let nib = UINib(safeWithName: reuseIdentifier, bundle: bundle) {
            register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func sw_dequeueCell<Cell: UITableViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
    
    func sw_register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let identifier = String(describing: headerFooterType)
        
        if tryNib, let nib = UINib(safeWithName: identifier, bundle: bundle) {
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    func sw_dequeueHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(of viewType: HeaderFooter.Type) -> HeaderFooter {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as! HeaderFooter
    }
    
}

// MARK: Deprecated

public extension UITableView {
    
    @available(*, deprecated, message: "Use sw_register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle, tryNib: Bool) instead")
    func sw_registerReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    
    @available(*, deprecated, message: "Use sw_register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle, tryNib: Bool) instead")
    func sw_registerReusableCellNibOfType<T: UITableViewCell>(_ cellType: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: String(describing: cellType), bundle: bundle)
        register(nib, forCellReuseIdentifier: String(describing: cellType))
    }
    
    @available(*, deprecated, message: "Use sw_dequeueCell<Cell: UITableViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell instead")
    func sw_dequeueReusableCellOfType<T: UITableViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! T
    }
    
    @available(*, deprecated, message: "Use sw_register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type, bundle: Bundle, tryNib: Bool) instead")
    func sw_registerReusableHeaderFooterViewOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        register(viewType, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
    
    @available(*, deprecated, message: "Use sw_register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type, bundle: Bundle, tryNib: Bool) instead")
    func sw_registerHeaderFooterViewNibOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: String(describing: viewType), bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
    
    @available(*, deprecated, message: "sw_dequeueHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(of viewType: HeaderFooter.Type) -> HeaderFooter")
    func sw_dequeueReusableHeaderFooterViewOfType<T: UITableViewHeaderFooterView>(_ viewType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as! T
    }
}
