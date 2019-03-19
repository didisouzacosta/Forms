//
//  FormRuleProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol FormRuleProtocol {
    
    var message: String { get }
    
    @discardableResult
    func validate(_ value: Any?) throws -> Bool
    
}
