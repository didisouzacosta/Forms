//
//  SelectFieldValue.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import Foundation

public protocol SelectFieldValue: EmptyRepresentable {
    
    var valueDescription: String? { get }
    
}

extension String: SelectFieldValue {
    public var valueDescription: String? { return self }
}

extension Bool: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension Double: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension Float: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension CGPoint: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension Data: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension Date: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}

extension Int: SelectFieldValue {
    public var valueDescription: String? { return String(describing: self) }
}
