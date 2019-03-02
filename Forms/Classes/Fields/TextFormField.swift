//
//  TextFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

final public class TextFormField: BaseFormField<String> {
    
    public var text: ValueType {
        get { return value }
        set { value = newValue }
    }
    
}
