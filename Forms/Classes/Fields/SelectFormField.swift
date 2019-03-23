//
//  SelectFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import UIKit

final public class SelectFormField: FormFieldProtocol, FormFieldCellSelectable {
    
    public var title: String
    public var isEnabled: Bool = true
    public var isVisible: Bool = true
    public var errors: [Error] = []
    public var acessory: UITableViewCell.AccessoryType
    public var placeholder: String?
    
    public var value: SelectFieldValueRepresentable {
        didSet { reload() }
    }
    
    public var handler: () -> Void {
        get { return { [weak self] in self?._handler() } }
        set {}
    }
    
    public var rules: [FormRuleProtocol] = []
    
    public var cellIdentifier: String {
        return SelectFormFieldCell.identifier
    }
    
    // MARK: - Private Variables
    
    private var _handler: () -> Void = {}
    
    // MARK: - Life Cycle
    
    public init<T: SelectFieldValueRepresentable>( value: T, label: String, placeholder: String? = nil, acessory: UITableViewCell.AccessoryType = .disclosureIndicator, handler: @escaping (T?) -> Void) {
        self.value = value
        self.title = label
        self.placeholder = placeholder
        self.acessory = acessory
        
        defer {
            self._handler = { [weak self] in
                handler(self?.value as? T)
            }
        }
    }
    
    // MARK: - Public Methods
    
    public func validate() throws {}
    
}

public class SelectFormFieldCell: BaseFormFieldCell<SelectFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void = {}
    
    override var titleLabel: UILabel? {
        return _titleLabel
    }
    
    override var errorLabel: UILabel? {
        return _errorLabel
    }
    
    override var contentStack: UIStackView? {
        return _contentStack
    }
    
    // MARK: Outlets
    
    @IBOutlet private weak var _titleLabel: UILabel?
    @IBOutlet private weak var _errorLabel: UILabel?
    @IBOutlet private weak var _contentStack: UIStackView?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        self.handler = field?.handler ?? {}
        
        accessoryType = field?.acessory ?? .none
    }
    
}
