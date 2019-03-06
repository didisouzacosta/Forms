//
//  TextFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class TextFormFieldCell: BaseFormFieldCell<TextFormField> {
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueLabel: UITextField?
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    public override func setup(with field: TextFormField?) {
        valueLabel?.text = field?.text
        valueLabel?.placeholder = field?.placeholder
    }
    
}
