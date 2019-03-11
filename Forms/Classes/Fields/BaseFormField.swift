//
//  BaseField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public class BaseFormField<T: Equatable>: FormFieldRepresentable {
    
    public typealias ValueType = T
    public typealias UpdatedHandler = (_ newValue: ValueType?, _ oldValue: ValueType?) -> Void
    
    // MARK: - Public Variables
    
    public var rules: [FormRuleRepresentable] = []
    public var placeholder: String?
    
    public var label: String {
        didSet { reload() }
    }
    
    public var isEnabled: Bool = true {
        didSet { reload() }
    }
    
    public var value: ValueType? {
        didSet {
            guard oldValue != value else { return }
            self.oldValue = oldValue
            fireValueUpdatedHandlers(newValue: value, oldValue: oldValue)
            reload()
        }
    }
    
    public var cellIdentifier: String {
        fatalError("Override this property 'cell'.")
    }
    
    // MARK: - Private Variables
    
    private var oldValue: ValueType?
    private var valueUpdatedHandlers: [UpdatedHandler] = []
    
    // MARK: - Life Cycle
    
    public init(value: ValueType? = nil, label: String, placeholder: String? = nil) {
        self.value = value
        self.label = label
        self.placeholder = placeholder
    }
    
    // MARK: - Public Methods
    
    public func valueUpdated(fire: Bool = true, handler: @escaping UpdatedHandler) {
        valueUpdatedHandlers.append(handler)
        
        if fire {
            self.fireValueUpdatedHandlers(newValue: value, oldValue: oldValue)
        }
    }
    
    public func clearValueUpdatedHandlers() {
        valueUpdatedHandlers.removeAll()
    }
    
    public func validate() throws -> Bool {
        return try rules.reduce(true) { (result, rule) -> Bool in
            return try rule.validate(value) == result
        }
    }
    
    // MARK: - Private Methods
    
    private func fireValueUpdatedHandlers(newValue: ValueType?, oldValue: ValueType?) {
        valueUpdatedHandlers.forEach { $0(newValue, oldValue) }
    }
    
}

