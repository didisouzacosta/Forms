//
//  DateFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

final public class DateFormField: BaseFormField<Date>, FormFieldSelectable {
    
    public override var cell: FormCell {
        return DateFormFieldCell()
    }
    
    public var handler: (() -> Void)?
    
    public var date: ValueType {
        get { return value }
        set { value = newValue }
    }
    
    public init(value: ValueType, label: String, placeholder: String? = nil, action handler: @escaping () -> Void) {
        self.handler = handler
        super.init(value: value, label: label, placeholder: placeholder)
    }
    
}
