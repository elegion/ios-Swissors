//
//  FileManager+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/13/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension FileManager {
    
    public func URL(for directory: SearchPathDirectory, in domain: SearchPathDomainMask, append pathComponent: String?, create: Bool) throws -> URL {
        var url = try self.url(for: directory, in: domain, appropriateFor: nil, create: create)
        
        if let pathComponent = pathComponent {
            url.appendPathComponent(pathComponent)
        }
        
        if create && !self.fileExists(atPath: url.path, isDirectory: nil) {
            try self.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return url
    }
    
}
