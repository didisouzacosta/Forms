//
//  RuleFieldSet.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public protocol RuleFieldSet {
    
    var rules: [FormRuleRepresentable] { get set }
    
    @discardableResult
    func validate() throws -> Bool
    
}
