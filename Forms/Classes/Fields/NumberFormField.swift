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
