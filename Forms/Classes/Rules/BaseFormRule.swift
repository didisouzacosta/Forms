//
//  FormBaseRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public class BaseFormRule<T>: FormRuleProtocol {
    
    public var message: String
    
    public init(message: String) {
        self.message = message
    }
    
    @discardableResult
    final public func validate(_ value: Any?) throws -> Bool {
        return try validate(value as? T)
    }
    
    @discardableResult
    public func validate(_ value: T?) throws -> Bool {
        fatalError("Override the method 'func validate(_ value: T) throws -> Bool'")
    }
    
}
