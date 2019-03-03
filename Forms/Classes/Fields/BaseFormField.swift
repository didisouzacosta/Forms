//
//  BaseField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public class BaseFormField<T: Equatable>: FormFieldRepresentable {
    
    public typealias ValueType = T?
    
    // MARK: - Public Variables
    
    public var rules: [FormRuleRepresentable] = []
    
    public var value: ValueType {
        didSet { valueChangedHandler?(value, oldValue) }
    }
    
    public var isEnabled: Bool = true {
        didSet { isEnabledChangedHandler?(isEnabled, oldValue) }
    }
    
    public var valueChangedHandler: ((_ newValue: ValueType, _ oldValue: ValueType) -> Void)?
    public var isEnabledChangedHandler: ((_ newValue: Bool, _ oldValue: Bool) -> Void)?
    
    // MARK: - Private Variables
    // MARK: - Life Cycle
    
    public init(value: ValueType = nil) {
        self.value = value
    }
    
    // MARK: - Public Methods
    
    public func validate() throws -> Bool {
        return try rules.reduce(true) { (result, rule) -> Bool in
            return try rule.validate(value) == result
        }
    }
    
}

