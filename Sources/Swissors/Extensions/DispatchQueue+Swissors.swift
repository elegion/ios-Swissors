//
//  DispatchQueue+Swissors.swift
//  Swissors
//
//  Created by Алексей Мошкин on 07.02.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation

extension DispatchQueue {
    class var sw_currentLabel: String {
        return String(validatingUTF8: __dispatch_queue_get_label(nil)) ?? "unknown"
    }
    
    func sw_safeSerialSync(execute block: @escaping () -> Void) {
        if label == DispatchQueue.sw_currentLabel {
            block()
        } else {
            sync(execute: block)
        }
    }
}
