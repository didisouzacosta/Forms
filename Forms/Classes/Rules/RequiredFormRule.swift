//
//  RequiredFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public struct RequiredFormRule: FormRuleRepresentable {
    
    public typealias RuleValueType = EmptyRepresentable
    
    public var message: String
    
    public init(message: String) {
        self.message = message
    }
    
    public func validate(_ value: RuleValueType?) throws -> Bool {
        if let value = value, value.isEmpty == false {
            return true
        } else {
            throw message
        }
    }
    
}
