//
//  NSAttributedString+Swissors.swift
//  Swissors
//
//  Created by Nikolay Ischuk on 03.04.17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

extension NSAttributedString {
    func sw_sizeConstrained(to width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

        return boundingBox.size
    }
}
