//
//  NumberFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 08/03/19.
//

import UIKit

final public class NumberFormField: BaseFormField<Double> {
    
    public override var cellIdentifier: String {
        return NumberFormFieldCell.identifier
    }
    
}

public class NumberFormFieldCell: BaseFormFieldCell<NumberFormField> {
    
    // MARK: - Public Variables
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueLabel: UITextField?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        if let value = field?.value {
            valueLabel?.text = String(value)
        }
        
        valueLabel?.placeholder = field?.placeholder
    }
    
}
