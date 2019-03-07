//
//  CountRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol CountRepresentable {
    
    var valueCount: Float { get }
    
}

extension Date: CountRepresentable {
    
    public var valueCount: Float {
        return Float(self.timeIntervalSinceReferenceDate)
    }
    
}

extension Data: CountRepresentable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}

extension Int: CountRepresentable {
    
    public var valueCount: Float {
        return Float(self)
    }
    
}

extension String: CountRepresentable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}

extension Array: CountRepresentable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}
