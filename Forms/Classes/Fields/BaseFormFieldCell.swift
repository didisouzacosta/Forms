//
//  BaseFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public typealias FormFieldCell = UITableViewCell & FormCellProtocol

public class BaseFormFieldCell<T: FormFieldProtocol>: FormFieldCell {
    
    // MARK: - Public Variables
    
    weak var titleLabel: UILabel? { return nil }
    weak var errorLabel: UILabel? { return nil }
    weak var contentStack: UIStackView? { return nil }
    
    public override var isUserInteractionEnabled: Bool {
        get { return field?.isEnabled ?? true }
        set { field?.isEnabled = newValue }
    }
    
    // MARK: - Private Variables
    
    internal weak var field: T?
    
    // MARK: Outlets
    
    // MARK: - Public Methods
    
    final public func setup(with field: FormFieldProtocol) {
        self.field = field as? T
        setupContent()
    }
    
    public func setupContent() {
        guard let field = field else { return }
        
        titleLabel?.text = field.title
        
        if field.showErros {
            errorLabel?.isHidden = field.isValid
            errorLabel?.text = field.errors.first?.localizedDescription
            errorLabel?.textColor = .red
        } else {
            errorLabel?.isHidden = true
        }
        
        UIView.animate(withDuration: 0.26) { [weak self] in
            guard let self = self else { return }
            self.contentView.alpha = self.isUserInteractionEnabled ? 1 : 0.4
        }
    }
    
}
