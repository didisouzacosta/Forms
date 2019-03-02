//
//  FormRuleSet.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol FormRuleRepresentable {
    
    associatedtype RuleValueType
    
    var message: String { get }
    
    func validate(_ value: RuleValueType?) throws -> Bool
    
}
