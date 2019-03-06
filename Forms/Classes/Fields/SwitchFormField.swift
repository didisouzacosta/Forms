//
//  SwitchFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 05/03/19.
//

final public class SwitchFormField: BaseFormField<Bool> {
    
    public override var cell: FormCell {
        return SwitchFormFieldCell()
    }
    
    public var date: ValueType {
        get { return value }
        set { value = newValue }
    }
    
}
