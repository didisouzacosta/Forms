//
//  FormIdentifiable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 13/03/19.
//

public protocol FormIdentifiable {
    
    var identifier: String { get }
    
    func isEqual<F: FormIdentifiable>(_ item: F?) -> Bool
    
}

fileprivate struct AssociatedKeys {
    static var identifierKey = "identifier.key"
}

extension FormIdentifiable {
    
    public var identifier: String {
        if let identifier = objc_getAssociatedObject(self, &AssociatedKeys.identifierKey) as? String {
            return identifier
        }
        
        let newUID = UUID().uuidString
        
        objc_setAssociatedObject(self, &AssociatedKeys.identifierKey, newUID, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return newUID
    }
    
    public func isEqual<F: FormIdentifiable>(_ item: F?) -> Bool {
        return identifier == item?.identifier
    }
    
}
