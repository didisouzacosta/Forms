//
//  SwitchFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 05/03/19.
//

import UIKit

public class SwitchFormFieldCell: BaseFormFieldCell<SwitchFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    public var handler: (() -> Void)? {
        return { [weak self] in
            let currentValue = self?.valueSwitch?.isOn ?? false
            self?.valueSwitch?.setOn(!currentValue, animated: true)
        }
    }
    
    // MARK: - Private Variables
    
    private var field: SwitchFormField?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueSwitch: UISwitch?
    
    // MARK: - Public Methods
    
    public override func setup(with field: SwitchFormField?) {
        self.field = field
        valueSwitch?.isOn = field?.value ?? false
        valueSwitch?.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func valueChanged(_ outlet: UISwitch) {
        field?.value = outlet.isOn
    }
    
}
