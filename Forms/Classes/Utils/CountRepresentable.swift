//
//  CountRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol CountRepresentable {
    
    var valueCount: Float { get }
    
}

extension Int: CountRepresentable {
    
    public var valueCount: Float {
        return Float(self)
    }
    
}

extension Array: CountRepresentable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}
