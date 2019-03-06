//
//  DateFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class DateFormFieldCell: BaseFormFieldCell<DateFormField>, FormFieldCellSelectable {
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    public var handler: (() -> Void)?
    
    public override func setup(with field: DateFormField?) {
        handler = field?.handler
        
        guard let date = field?.date else { return }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        valueLabel?.text = formatter.string(from: date)
    }
    
}
