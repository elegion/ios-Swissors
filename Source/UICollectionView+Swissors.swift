//
//  UICollectionView+Swissors.swift
//  alphadirect
//
//  Created by Николай Кагала on 13/10/16.
//  Copyright © 2016 e-Legion. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    //MARK: Cells
    
    public func sw_registerReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    public func sw_registerReusableCellNib<T: UICollectionViewCell>(ofType cellType: T.Type, bundle: Bundle? = .main) {
        let nib = UINib(nibName: String(describing: cellType), bundle: bundle)
        register(nib, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    public func sw_dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! T
    }
    
    //MARK: Supplementary Views
    
    public func sw_registerReusableSupplementaryView<T: UICollectionReusableView>(ofType type: T.Type, kind: String) {
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }
    
    public func sw_registerReusableSupplementaryViewNib<T: UICollectionReusableView>(ofType type: T.Type, kind: String, bundle: Bundle? = .main) {
        let nib = UINib(nibName: String(describing: type), bundle: bundle)
        register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: String(describing: type))
    }
    
    public func sw_dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofType type: T.Type, kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: type), for: indexPath) as! T
    }
}

