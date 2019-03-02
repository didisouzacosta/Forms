//
//  FormFieldRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public protocol FormFieldRepresentable {
    
    var identifier: String { get }
    var isValid: Bool { get }
    var isEnabled: Bool { get }
    
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
    
    public var isValid: Bool {
        return true
    }
    
    public func isEqual<F: FormFieldRepresentable>(_ field: F?) -> Bool {
        return identifier == field?.identifier
    }
    
}
