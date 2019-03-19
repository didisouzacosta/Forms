//
//  BaseField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public class BaseFormField<T: Equatable>: FormFieldProtocol {
    
    public typealias ValueType = T
    public typealias UpdatedValueHandler = (_ newValue: ValueType?, _ oldValue: ValueType?) -> Void
    
    // MARK: - Public Variables
    
    public var rules: [FormRuleProtocol] = []
    public var placeholder: String?
    public var label: String
    
    public var isEnabled: Bool = true {
        didSet { reload() }
    }
    
    public var value: ValueType? {
        didSet {
            guard oldValue != value else { return }
            self.oldValue = oldValue
            valueUpdatedHandlers.forEach { $0(value, oldValue) }
            reload()
        }
    }
    
    public var cellIdentifier: String {
        fatalError("Override this property 'cell'.")
    }
    
    // MARK: - Private Variables
    
    private var oldValue: ValueType?
    private var valueUpdatedHandlers: [UpdatedValueHandler] = []
    
    // MARK: - Life Cycle
    
    public init(value: ValueType? = nil, label: String, placeholder: String? = nil) {
        self.value = value
        self.label = label
        self.placeholder = placeholder
    }
    
    // MARK: - Public Methods
    
    public func valueUpdated(fire: Bool = true, handler: @escaping UpdatedValueHandler) {
        valueUpdatedHandlers.append(handler)
        
        if fire {
            handler(value, oldValue)
        }
    }
    
    public func validate() throws -> Bool {
        return try rules.reduce(true) { (result, rule) -> Bool in
            return try rule.validate(value) == result
        }
    }
    
}

