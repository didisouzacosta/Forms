//
//  Dynamic.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation

public struct Dynamic<T> {
    
    public typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    public var value: T {
        didSet {
            fire(value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
    
    public mutating func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    public mutating func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        fire(value)
    }
    
    public func fire(_ value: T) {
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(value)
            }
        }
    }
    
}
