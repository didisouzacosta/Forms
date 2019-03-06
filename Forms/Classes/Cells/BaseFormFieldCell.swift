//
//  BaseFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class BaseFormFieldCell<T: FormFieldRepresentable>: UITableViewCell, FormCellRepresentable {
    
    // MARK: - Public Variables
    
    public var identifier: String {
        return String(describing: type(of: self))
    }
    
    public var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: type(of: self)))
    }
    
    public override var reuseIdentifier: String? {
        return identifier
    }
    
    // MARK: - Private Variables
    
    internal var labelOutlet: UILabel? { return nil }
    internal var errorOutlet: UILabel? { return nil }
    internal var stackOutlet: UIStackView? { return nil }
    
    // MARK: - Public Methods
    
    final public func setup(with field: FormFieldRepresentable) {
        labelOutlet?.text = field.label
        setup(with: field as? T)
        updateLayout()
    }
    
    public func setup(with field: T?) {
        fatalError("Override method 'setup'.")
    }
    
    public func updateLayout() {
        errorOutlet?.isHidden = true
    }
    
}
