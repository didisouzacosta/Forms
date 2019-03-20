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
    @IBOutlet private weak var valueLabel: UILabel?
    
    // MARK: - Public Methods
    
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
