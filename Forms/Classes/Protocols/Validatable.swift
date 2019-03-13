//
//  Validatable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 12/03/19.
//

public protocol Validatable {
    
    @discardableResult
    func validate() throws -> Bool
    
}
