//
//  Throttler.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 5/30/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

class Throttler {
    
    let delay: TimeInterval
    let executionQueue: DispatchQueue
    private var currentItem: DispatchWorkItem?
    
    init(delay: TimeInterval, queue: DispatchQueue = .main) {
        self.delay = delay
        self.executionQueue = queue
    }
    
    func add(workItem: DispatchWorkItem, force: Bool) {
        add(workItem: workItem, force: force, delay: delay)
    }
    
    func add(workItem: DispatchWorkItem, force: Bool, delay: TimeInterval) {
        currentItem?.cancel()
        currentItem = workItem
        
        if force {
            executionQueue.async {
                workItem.perform()
            }
        } else {
            executionQueue.asyncAfter(deadline: .now() + delay) {
                if self.currentItem === workItem {
                    self.currentItem = nil
                    workItem.perform()
                }
            }
        }
    }
    
    func reset() {
        currentItem?.cancel()
        currentItem = nil
    }
    
}

extension Throttler {
    
    func add(force: Bool, closure: @escaping () -> Void) {
        add(workItem: DispatchWorkItem(block: closure), force: force)
    }
    
    func add(force: Bool, delay: TimeInterval, closure: @escaping () -> Void) {
        add(workItem: DispatchWorkItem(block: closure), force: force, delay: delay)
    }
    
}
