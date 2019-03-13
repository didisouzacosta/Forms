//
//  DateFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import UIKit

final public class DateFormField: BaseFormField<Date> {
    
    public override var cellIdentifier: String {
        return DateFormFieldCell.identifier
    }
    
    public var date: ValueType? {
        get { return value }
        set { value = newValue }
    }
    
}

public class DateFormFieldCell: BaseFormFieldCell<DateFormField> {
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    public override func setupContent() {
        super.setupContent()
        
        if let date = field?.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            valueLabel?.text = formatter.string(from: date)
        } else {
            valueLabel?.text = field?.placeholder
        }
    }
    
}
