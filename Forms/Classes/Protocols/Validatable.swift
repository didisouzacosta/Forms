//
//  Validatable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 12/03/19.
//

public protocol Validatable {
    
    var isValid: Bool { get }
    var errors: [Error] { get }
    
    func validate() throws
    
}
