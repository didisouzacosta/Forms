//
//  DateFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

final public class DateFormField: BaseFormField<Date> {
    
    public override var cell: FormCell {
        return DateFormFieldCell()
    }
    
    public var date: ValueType {
        get { return value }
        set { value = newValue }
    }
    
}
