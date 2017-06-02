//
//  UICollectionView+Swissors.swift
//  alphadirect
//
//  Created by Николай Кагала on 13/10/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    public func sw_register<Cell: UICollectionViewCell>(cellType: Cell.Type, bundle: Bundle = .main, tryNib: Bool = true) {
        let reuseIdentifier = String(describing: cellType)
        
        if tryNib, let nib = UINib(safeWithName: reuseIdentifier, bundle: bundle) {
            register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    public func sw_dequeueCell<Cell: UICollectionViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
    
    public func sw_register<SupplementaryView: UICollectionReusableView>(supplementaryViewType: SupplementaryView.Type, kind: String, bundle: Bundle = .main, tryNib: Bool = true) {
        let identifier = String(describing: supplementaryViewType)
        
        if tryNib, let nib = UINib(safeWithName: identifier, bundle: bundle) {
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            register(supplementaryViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
    public func sw_dequeueHeaderFooter<SupplementaryView: UICollectionReusableView>(of viewType: SupplementaryView.Type, kind: String, for indexPath: IndexPath) -> SupplementaryView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: viewType), for: indexPath) as! SupplementaryView
    }
    
}

public extension UICollectionView {
    
    //MARK: Cells
    @available(*, deprecated, message: "Use sw_register<Cell: UICollectionViewCell>(cellType: Cell.Type, bundle: Bundle, tryNib: Bool) instead")
    public func sw_registerReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    @available(*, deprecated, message: "Use sw_register<Cell: UICollectionViewCell>(cellType: Cell.Type, bundle: Bundle, tryNib: Bool) instead")
    public func sw_registerReusableCellNib<T: UICollectionViewCell>(ofType cellType: T.Type, bundle: Bundle? = .main) {
        let nib = UINib(nibName: String(describing: cellType), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    @available(*, deprecated, message: "Use sw_dequeueCell<Cell: UICollectionViewCell>(of cellType: Cell.Type, for indexPath: IndexPath) instead")
    public func sw_dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! T
    }
    
    //MARK: Supplementary Views
    
    @available(*, deprecated, message: "Use sw_register<SupplementaryView: UICollectionReusableView>(supplementaryViewType: SupplementaryView.Type, kind: String, bundle: Bundle, tryNib: Bool) instead")
    public func sw_registerReusableSupplementaryView<T: UICollectionReusableView>(ofType type: T.Type, kind: String) {
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }
    
    @available(*, deprecated, message: "Use sw_register<SupplementaryView: UICollectionReusableView>(supplementaryViewType: SupplementaryView.Type, kind: String, bundle: Bundle, tryNib: Bool) instead")
    public func sw_registerReusableSupplementaryViewNib<T: UICollectionReusableView>(ofType type: T.Type, kind: String, bundle: Bundle? = .main) {
        let nib = UINib(nibName: String(describing: type), bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: type))
    }
    
    @available(*, deprecated, message: "Use sw_dequeueHeaderFooter<SupplementaryView: UICollectionReusableView>(of viewType: SupplementaryView.Type, kind: String, for indexPath: IndexPath) instead")
    public func sw_dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofType type: T.Type, kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}

