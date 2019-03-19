//
//  RequiredFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public class RequiredFormRule: BaseFormRule<EmptyValueRepresentable> {
    
    @discardableResult
    public override func validate(_ value: EmptyValueRepresentable?) throws -> Bool {
        guard let value = value, value.valueIsEmpty == false else { throw message }
        return true
    }
    
}
