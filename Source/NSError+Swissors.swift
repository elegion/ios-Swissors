//
//  NSError+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/13/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension NSError {
    
    public var sw_isNetworkConnectionError: Bool {
        let codes = [
            NSURLErrorTimedOut,
            NSURLErrorCannotFindHost,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorDNSLookupFailed,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorInternationalRoamingOff,
            NSURLErrorCallIsActive,
            NSURLErrorDataNotAllowed
        ]
        
        return sw_matches(domain: NSURLErrorDomain, codes: codes, includeUnderlying: true)
    }
    
    public var sw_isNetworkCancelledError: Bool {
        return sw_matches(domain: NSURLErrorDomain, codes: [NSURLErrorCancelled])
    }
    
    public func sw_matches(domain: String, codes: [Int], includeUnderlying: Bool = false) -> Bool {
        guard self.domain == domain else {
            if includeUnderlying, let underlying = userInfo[NSUnderlyingErrorKey] as? NSError {
                return underlying.sw_matches(domain: domain, codes:codes, includeUnderlying: includeUnderlying)
            }
            
            return false
        }
        
        return codes.contains(code)
    }
    
}
