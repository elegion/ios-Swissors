//
//  Closure.swift
//  Swissors
//
//  Created by viktor.volkov on 15.04.2022.
//

import Foundation

/// Набор typealias для замыканий
public enum Closure {
    
    /// ((T) -> Void)
    public typealias In<T> = ((T) -> Swift.Void) // swiftlint:disable:this type_name
    
    /// (() -> T)
    public typealias Out<T> = (() -> T)
    
    /// ((In) -> Out)
    public typealias InOut<In, Out> = ((In) -> Out)
    
    /// (() -> Void)
    public typealias Void = (() -> Swift.Void)
    
    /// ((Bool) -> Void)
    public typealias Boolean = In<Bool>
    
    /// ((Int) -> Void)
    public typealias Int = In<Swift.Int>
    
    /// ((UInt) -> Void)
    public typealias UInt = In<Swift.UInt>
    
    /// ((Float) -> Void)
    public typealias Float = In<Swift.Float>
    
    /// ((Double) -> Void)
    public typealias Double = In<Swift.Double>
    
    /// ((String) -> Void)
    public typealias String = In<Swift.String>
    
    /// ((URL) -> Void)
    public typealias URL = In<Foundation.URL>
    
    /// (([T]) -> Void)
    public typealias Array<T> = In<Swift.Array<T>> // swiftlint:disable:this syntactic_sugar
    
    /// ((T) -> Void)
    public typealias Generic<T> = In<T>
}
