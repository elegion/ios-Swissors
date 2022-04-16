//
//  UITableView+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 8/3/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UITableView {
    
    func register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if tryNib, let nib = UINib(safeWithName: reuseIdentifier, bundle: bundle) {
            register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueCell<Cell: UITableViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell // swiftlint:disable:this force_cast
    }
    
    func register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type,
                                                             bundle: Bundle = .main,
                                                             tryNib: Bool = true) {
        let identifier = String(describing: headerFooterType)
        
        if tryNib, let nib = UINib(safeWithName: identifier, bundle: bundle) {
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    func dequeueHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(of viewType: HeaderFooter.Type) -> HeaderFooter {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewType)) as! HeaderFooter // swiftlint:disable:this force_cast
    }
    
    // MARK: Deprecated
    
    @available(*, deprecated, renamed: "register")
    func sw_register<Cell: UITableViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        register(cellType: cellType, bundle: bundle, tryNib: tryNib)
    }
    
    @available(*, deprecated, renamed: "dequeueCell")
    func sw_dequeueCell<Cell: UITableViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueCell(of: cellType, for: indexPath)
    }
    
    @available(*, deprecated, renamed: "register")
    func sw_register<HeaderFooter: UITableViewHeaderFooterView>(headerFooterType: HeaderFooter.Type,
                                                                bundle: Bundle = .main,
                                                                tryNib: Bool = true) {
        register(headerFooterType: headerFooterType, bundle: bundle, tryNib: tryNib)
    }
    
    @available(*, deprecated, renamed: "dequeueHeaderFooter")
    func sw_dequeueHeaderFooter<HeaderFooter: UITableViewHeaderFooterView>(of viewType: HeaderFooter.Type) -> HeaderFooter {
        dequeueHeaderFooter(of: viewType)
    }
}
