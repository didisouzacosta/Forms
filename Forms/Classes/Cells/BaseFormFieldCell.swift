//
//  BaseFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class BaseFormFieldCell<T: FormFieldRepresentable>: FormCell {
    
    public var identifier: String {
        return String(describing: type(of: self))
    }
    
    public var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: type(of: self)))
    }
    
    public override var reuseIdentifier: String? {
        return identifier
    }
    
    final public func setup(with field: FormFieldRepresentable) {
        setup(with: field as? T)
    }
    
    public func setup(with field: T?) {
        fatalError("Override method 'setup'.")
    }
    
}
