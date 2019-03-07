//
//  FormFieldCellSelectable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 06/03/19.
//

public protocol FormFieldCellSelectable {
    
    var handler: () -> Void { get }
    
}

public protocol FormFieldSelectable: FormFieldCellSelectable {}
