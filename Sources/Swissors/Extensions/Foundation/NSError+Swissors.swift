//
//  NSError+Swissors.swift
//  Swissors
//
//  Created by Ilya Kulebyakin on 6/13/17.
//  Copyright © 2017 e-Legion. All rights reserved.
//

import Foundation

public extension NSError {
    
    var isNetworkConnectionError: Bool {
        let codes = [
            NSURLErrorTimedOut,
            NSURLErrorCannotFindHost,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorDNSLookupFailed,
            NSURLErrorNotConnectedToInternet,
            NSURLErrorInternationalRoamingOff,
            NSURLErrorCallIsActive,
            NSURLErrorDataNotAllowed,
        ]
        
        return matches(domain: NSURLErrorDomain, codes: codes, includeUnderlying: true)
    }
    
    var isNetworkCancelledError: Bool {
        matches(domain: NSURLErrorDomain, codes: [NSURLErrorCancelled])
    }
    
    func matches(domain: String, codes: [Int], includeUnderlying: Bool = false) -> Bool {
        guard self.domain == domain else {
            if includeUnderlying, let underlying = userInfo[NSUnderlyingErrorKey] as? NSError {
                return underlying.matches(domain: domain, codes: codes, includeUnderlying: includeUnderlying)
            }
            return false
        }
        return codes.contains(code)
    }
    
    @available(*, deprecated, renamed: "isNetworkConnectionError")
    var sw_isNetworkConnectionError: Bool {
        isNetworkConnectionError
    }
    
    @available(*, deprecated, renamed: "isNetworkCancelledError")
    var sw_isNetworkCancelledError: Bool {
        isNetworkCancelledError
    }
    
    @available(*, deprecated, renamed: "matches")
    func sw_matches(domain: String, codes: [Int], includeUnderlying: Bool = false) -> Bool {
        matches(domain: domain, codes: codes, includeUnderlying: includeUnderlying)
    }
}
