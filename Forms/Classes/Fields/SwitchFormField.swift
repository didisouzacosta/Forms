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
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    public var handler: () -> Void {
        return { [weak self] in
            let newValue = !(self?.valueSwitch?.isOn ?? false)
            self?.valueSwitch?.setOn(newValue, animated: true)
            self?.field?.value = newValue
        }
    }
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueSwitch: UISwitch?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        valueSwitch?.setOn(field?.value ?? false, animated: false)
        valueSwitch?.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func valueChanged(_ outlet: UISwitch) {
        field?.value = outlet.isOn
    }
    
}
