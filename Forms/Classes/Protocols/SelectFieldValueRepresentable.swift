//
//  SelectFieldValueRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import Foundation

public protocol SelectFieldValueRepresentable: EmptyValueRepresentable {
    
    var valueDescription: String? { get }
    
}

extension String: SelectFieldValueRepresentable {
    public var valueDescription: String? { return self }
}

extension Bool: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension Double: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension Float: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension CGPoint: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension Data: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension Date: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}

extension Int: SelectFieldValueRepresentable {
    public var valueDescription: String? { return String(describing: self) }
}
