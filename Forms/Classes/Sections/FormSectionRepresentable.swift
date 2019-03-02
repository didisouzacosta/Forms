//
//  FormSectionRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import Foundation

public protocol FormSectionRepresentable {
    
    var fields: [FormFieldRepresentable] { get set }
    var isValid: Bool { get }

    func replace(_ field: FormFieldRepresentable)
    
}

public extension FormSectionRepresentable {
    
    public var isValid: Bool {
        return fields.reduce(true) { (result, field) -> Bool in
            return field.isValid == result
        }
    }

    public func replace(_ field: FormFieldRepresentable) {
        
    }
    
}
