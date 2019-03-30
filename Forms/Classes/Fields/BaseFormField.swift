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
    public var title: String
    
    public var isEnabled: Bool = true {
        didSet { reload() }
    }
    
    public var errors: [Error] {
        return rules.compactMap { rule -> Error? in
            do {
                try rule.validate(value)
                return nil
            } catch {
                return error
            }
        }
    }
    
    public var value: ValueType? {
        didSet {
            guard oldValue != value else { return }
            self.oldValue = oldValue
            DispatchQueue.main.async { [weak self] in
                self?.valueUpdatedHandlers.forEach { [weak self] handler in
                    handler(self?.value, oldValue)
                }
            }
            _ = try? validate()
        }
    }
    
    public var cellIdentifier: String {
        fatalError("Override this property 'cell'.")
    }
    
    // MARK: - Private Variables
    
    private var oldValue: ValueType?
    private var valueUpdatedHandlers: [UpdatedValueHandler] = []
    
    // MARK: - Life Cycle
    
    public init(value: ValueType? = nil, title: String, placeholder: String? = nil) {
        self.value = value
        self.title = title
        self.placeholder = placeholder
    }
    
    // MARK: - Public Methods
    
    public func valueUpdated(fire: Bool = true, handler: @escaping UpdatedValueHandler) {
        valueUpdatedHandlers.append(handler)
        
        if fire {
            handler(value, oldValue)
        }
    }
    
    public func validate() throws {
        showErros = true
        
        reload()
        
        if let error = errors.first {
            throw error
        }
    }
    
}

