//
//  TextFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class TextFormFieldCell: BaseFormFieldCell<TextFormField> {
    
    @IBOutlet private weak var textField: UITextField?
    
    public override func setup(with field: TextFormField?) {
        textField?.text = field?.text
    }
    
}
