//
//  SelectFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import UIKit

final public class SelectFormField: FormFieldRepresentable, FormFieldCellSelectable {
    
    public var label: String
    public var isEnabled: Bool = true
    public var acessory: UITableViewCell.AccessoryType
    public var placeholder: String?
    
    public var value: SelectFieldValue {
        didSet { reload() }
    }
    
    public var handler: () -> Void {
        get { return { [weak self] in self?._handler() } }
        set {}
    }
    
    public var rules: [FormRuleRepresentable] = []
    
    public func validate() throws -> Bool {
        return true
    }
    
    public var cellIdentifier: String {
        return SelectFormFieldCell.identifier
    }
    
    private var _handler: () -> Void = {}
    
    public init<T: SelectFieldValue>( value: T, label: String, placeholder: String? = nil, acessory: UITableViewCell.AccessoryType = .disclosureIndicator, handler: @escaping (T?) -> Void) {
        self.value = value
        self.label = label
        self.placeholder = placeholder
        self.acessory = acessory
        
        defer {
            self._handler = { [weak self] in
                handler(self?.value as? T)
            }
        }
    }
    
}

public class SelectFormFieldCell: BaseFormFieldCell<SelectFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void = {}
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    
    // MARK: - Public Methods
    
    public override func setup() {
        self.handler = field?.handler ?? {}
        
        errorLabel?.isHidden = true
        
        labelLabel?.text = field?.label
        valueLabel?.text = field?.value.valueIsEmpty ?? false ? field?.placeholder : field?.value.valueDescription
        valueLabel?.textColor = field?.value.valueIsEmpty ?? false ? .lightGray : .black
        
        accessoryType = field?.acessory ?? .none
    }
    
}
