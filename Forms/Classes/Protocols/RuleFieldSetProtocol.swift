//
//  RuleFieldSetProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol RuleFieldSetProtocol: Validatable {
    
    var rules: [FormRuleProtocol] { get set }
    
}
