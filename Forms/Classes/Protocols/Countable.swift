//
//  Countable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol Countable {
    
    var valueCount: Float { get }
    
}

extension Date: Countable {
    
    public var valueCount: Float {
        return Float(self.timeIntervalSinceReferenceDate)
    }
    
}

extension Data: Countable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}

extension Int: Countable {
    
    public var valueCount: Float {
        return Float(self)
    }
    
}

extension String: Countable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}

extension Array: Countable {
    
    public var valueCount: Float {
        return Float(count)
    }
    
}
