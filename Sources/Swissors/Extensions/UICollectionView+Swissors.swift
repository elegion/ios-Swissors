//
//  UICollectionView+Swissors.swift
//  alphadirect
//
//  Created by Николай Кагала on 13/10/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    func sw_register<Cell: UICollectionViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if tryNib, let nib = UINib(safeWithName: reuseIdentifier, bundle: bundle) {
            register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    func sw_dequeueCell<Cell: UICollectionViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! Cell // swiftlint:disable:this force_cast
    }
    
    func sw_register<SupplementaryView: UICollectionReusableView>(supplementaryViewType: SupplementaryView.Type, kind: String, bundle: Bundle = .main, tryNib: Bool = true) {
        let identifier = String(describing: supplementaryViewType)
        
        if tryNib, let nib = UINib(safeWithName: identifier, bundle: bundle) {
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            register(supplementaryViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
    func sw_dequeueHeaderFooter<SupplementaryView: UICollectionReusableView>(of viewType: SupplementaryView.Type, kind: String, for indexPath: IndexPath) -> SupplementaryView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: viewType), for: indexPath) as! SupplementaryView // swiftlint:disable:this force_cast
    }
}
