//
//  SectionForm.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

public final class SectionForm: FormSectionRepresentable {
    
    public var fields: [FormFieldRepresentable]
    
    public init(fields: FormFieldRepresentable...) {
        self.fields = fields
    }
    
}
