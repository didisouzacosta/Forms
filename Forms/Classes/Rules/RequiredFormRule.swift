//
//  RequiredFormRule.swift
//  Forms
//
//  Created by Adriano Souza Costa on 02/03/19.
//

public class RequiredFormRule: BaseFormRule<EmptyRepresentable> {
    
    @discardableResult
    public override func validate(_ value: EmptyRepresentable?) throws -> Bool {
        guard let value = value, value.valueIsEmpty == false else { throw message }
        return true
    }
    
}
