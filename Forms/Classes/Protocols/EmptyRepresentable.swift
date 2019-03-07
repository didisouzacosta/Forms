//
//  EmptyRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol EmptyRepresentable {
    
    var valueIsEmpty: Bool { get }
    
}

extension String: EmptyRepresentable {
    public var valueIsEmpty: Bool { return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}

extension Data: EmptyRepresentable {
    public var valueIsEmpty: Bool { return isEmpty }
}

extension Date: EmptyRepresentable {
    public var valueIsEmpty: Bool { return false }
}

extension Bool: EmptyRepresentable {
    public var valueIsEmpty: Bool { return self == false }
}

extension CGPoint: EmptyRepresentable {
    public var valueIsEmpty: Bool { return false }
}

extension Double: EmptyRepresentable {
    public var valueIsEmpty: Bool { return self <= 0.0 }
}

extension Float: EmptyRepresentable {
    public var valueIsEmpty: Bool { return self <= 0.0 }
}

extension Int: EmptyRepresentable {
    public var valueIsEmpty: Bool { return self <= 0 }
}
