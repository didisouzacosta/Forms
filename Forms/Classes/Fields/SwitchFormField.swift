//
//  SwitchFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 05/03/19.
//

import UIKit

final public class SwitchFormField: BaseFormField<Bool> {
    
    public override var cellIdentifier: String {
        return SwitchFormFieldCell.identifier
    }
    
    public var date: ValueType? {
        get { return value }
        set { value = newValue }
    }
    
}

public class SwitchFormFieldCell: BaseFormFieldCell<SwitchFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void {
        return { [weak self] in
            let newValue = !(self?.valueSwitch?.isOn ?? false)
            self?.valueSwitch?.setOn(newValue, animated: true)
            self?.field?.value = newValue
        }
    }
    
    // MARK: - Private Variables
    
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
    @IBOutlet private weak var valueSwitch: UISwitch?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        valueSwitch?.setOn(field?.value ?? false, animated: false)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func valueChanged(_ outlet: UISwitch) {
        field?.value = outlet.isOn
    }
    
}
