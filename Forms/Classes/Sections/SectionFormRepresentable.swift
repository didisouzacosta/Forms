//
//  FormSectionRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import Foundation

public protocol FormSectionRepresentable {
    
    var fields: [FormFieldRepresentable] { get set }

    func validate() throws -> Bool
    
}

extension FormSectionRepresentable {
    
    public func validate() throws -> Bool {
        return try fields.reduce(true) { (result, field) -> Bool in
            return try field.validate() == result
        }
    }
    
}
