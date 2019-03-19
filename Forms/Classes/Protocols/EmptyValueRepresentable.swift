//
//  EmptyRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol EmptyValueRepresentable {
    
    var valueIsEmpty: Bool { get }
    
}

extension String: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}

extension Data: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return isEmpty }
}

extension Date: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return false }
}

extension Bool: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return self == false }
}

extension CGPoint: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return false }
}

extension Double: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return self <= 0.0 }
}

extension Float: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return self <= 0.0 }
}

extension Int: EmptyValueRepresentable {
    public var valueIsEmpty: Bool { return self <= 0 }
}
