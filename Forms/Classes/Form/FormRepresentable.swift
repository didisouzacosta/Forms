//
//  FormRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public protocol FormRepresentable {
    
    var sections: [FormSectionRepresentable] { get set }
    
    func validate() throws -> Bool
    
}

extension FormRepresentable {
    
    public func validate() throws -> Bool {
        return try sections.reduce(true) { (result, section) -> Bool in
            return try section.validate() == result
        }
    }
    
}
