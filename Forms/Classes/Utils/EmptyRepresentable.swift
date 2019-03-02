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

extension Double: EmptyRepresentable {
    public var isEmpty: Bool { return self > 0.0 }
}

extension CGFloat: EmptyRepresentable {
    public var isEmpty: Bool { return self > 0.0 }
}

extension Int: EmptyRepresentable {
    public var isEmpty: Bool { return self > 0 }
}
