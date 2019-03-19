//
//  RuleFieldSetProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol RuleFieldSetProtocol {
    
    var rules: [FormRuleProtocol] { get set }
    
    @discardableResult
    func validate() throws -> Bool
    
}
