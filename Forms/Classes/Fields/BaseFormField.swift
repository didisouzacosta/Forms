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
    
    public var placeholder: String?
    
    public var label: String {
        didSet { reload() }
    }
    
    public var isEnabled: Bool = true {
        didSet { reload() }
    }
    
    public var value: ValueType {
        didSet { reload() }
    }
    
    public var cellIdentifier: String {
        fatalError("Override this property 'cell'.")
    }
    
    // MARK: - Private Variables
    // MARK: - Life Cycle
    
    public init(value: ValueType = nil, label: String, placeholder: String? = nil) {
        self.value = value
        self.label = label
        self.placeholder = placeholder
    }
    
    // MARK: - Public Methods
    
    public func validate() throws -> Bool {
        return try rules.reduce(true) { (result, rule) -> Bool in
            return try rule.validate(value) == result
        }
    }
    
}

