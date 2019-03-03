//
//  EmptyRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol EmptyRepresentable {
    
    var isEmpty: Bool { get }
    
}

extension String: EmptyRepresentable {}
extension Data: EmptyRepresentable {}

extension Date: EmptyRepresentable {
    public var isEmpty: Bool { return false }
}

extension Bool: EmptyRepresentable {
    public var isEmpty: Bool { return self == false }
}

extension CGPoint: EmptyRepresentable {
    public var isEmpty: Bool { return false }
}

extension Double: EmptyRepresentable {
    public var isEmpty: Bool { return self <= 0.0 }
}

extension Float: EmptyRepresentable {
    public var isEmpty: Bool { return self <= 0.0 }
}

extension Int: EmptyRepresentable {
    public var isEmpty: Bool { return self <= 0 }
}
