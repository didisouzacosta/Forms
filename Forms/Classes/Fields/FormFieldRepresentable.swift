//
//  FormFieldRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import UIKit

public protocol FormFieldRepresentable: RuleFieldSet {
    
    var identifier: String { get }
    var label: String { get }
    var placeholder: String? { get }
    var isEnabled: Bool { get }
    var cell: FormCell { get }
    
}

fileprivate struct AssociatedKeys {
    static var identifierKey = "identifier.key"
}

public extension FormFieldRepresentable {
    
    public var identifier: String {
        if let identifier = objc_getAssociatedObject(self, &AssociatedKeys.identifierKey) as? String {
            return identifier
        }
        
        let newUID = UUID().uuidString
        
        objc_setAssociatedObject(self, &AssociatedKeys.identifierKey, newUID, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return newUID
    }
    
    public func isEqual<F: FormFieldRepresentable>(_ field: F?) -> Bool {
        return identifier == field?.identifier
    }
    
}
