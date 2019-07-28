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
