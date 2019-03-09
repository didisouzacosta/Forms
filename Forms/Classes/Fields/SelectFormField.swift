//
//  SelectFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 09/03/19.
//

import UIKit

final public class SelectFormField: FormFieldRepresentable, FormFieldCellSelectable {
    
    public var label: String
    public var value: SelectFieldValue?
    public var isEnabled: Bool = true
    public var acessory: UITableViewCell.AccessoryType
    
    public var handler: () -> Void {
        get { return { [weak self] in self?._handler() } }
        set {}
    }
    
    public var placeholder: String? {
        return nil
    }
    
    public var rules: [FormRuleRepresentable] = []
    
    public func validate() throws -> Bool {
        return true
    }
    
    public var cellIdentifier: String {
        return "SelectFormFieldCell"
    }
    
    private var _handler: () -> Void = {}
    
    public init<T: SelectFieldValue>(label: String, value: T? = nil, acessory: UITableViewCell.AccessoryType = .disclosureIndicator, handler: @escaping (T?) -> Void) {
        self.label = label
        self.value = value
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
    
    public static var identifier: String {
        return "SelectFormFieldCell"
    }
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    
    // MARK: - Public Methods
    
    public override func setup(with field: SelectFormField?) {
        self.handler = field?.handler ?? {}
        errorLabel?.isHidden = true
        labelLabel?.text = field?.label
        valueLabel?.text = field?.value?.valueDescription
        accessoryType = field?.acessory ?? .none
    }
    
}
