//
//  BaseFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public typealias FormFieldCell = UITableViewCell & FormCellRepresentable

public class BaseFormFieldCell<T: FormFieldRepresentable>: FormFieldCell {
    
    // MARK: - Public Variables
    
    public override var isUserInteractionEnabled: Bool {
        get { return field?.isEnabled ?? true }
        set { field?.isEnabled = newValue }
    }
    
    // MARK: - Private Variables
    
    internal weak var field: T?
    
    internal var labelOutlet: UILabel? { return nil }
    internal var errorOutlet: UILabel? { return nil }
    internal var stackOutlet: UIStackView? { return nil }
    
    // MARK: - Public Methods
    
    final public func setup(with field: FormFieldRepresentable) {
        self.field = field as? T
        
        setup()
        
        labelOutlet?.text = field.label
        errorOutlet?.isHidden = true
        contentView.alpha = isUserInteractionEnabled ? 1 : 0.4
    }
    
    public func setup() {}
    
}
