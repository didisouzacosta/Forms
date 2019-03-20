//
//  TextFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

final public class TextFormField: BaseFormField<String> {
    
    public override var cellIdentifier: String {
        return TextFormFieldCell.identifier
    }
    
    public var text: ValueType? {
        get { return value }
        set { value = newValue }
    }
    
}

public class TextFormFieldCell: BaseFormFieldCell<TextFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void {
        get {
            return { [weak self] in
                self?.textField?.becomeFirstResponder()
            }
        }
        set {}
    }
    
    // MARK: - Private Variables
    
    override var titleLabel: UILabel? {
        return _titleLabel
    }
    
    override var errorLabel: UILabel? {
        return _errorLabel
    }
    
    override var contentStack: UIStackView? {
        return _contentStack
    }
    
    // MARK: Outlets
    
    @IBOutlet private weak var _titleLabel: UILabel?
    @IBOutlet private weak var _errorLabel: UILabel?
    @IBOutlet private weak var _contentStack: UIStackView?
    @IBOutlet private weak var textField: UITextField?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        textField?.text = field?.text
        textField?.placeholder = field?.placeholder
    }
    
    // MARK: - Private Methods
    
    @IBAction private func updateText(_ textField: UITextField) {
        field?.text = textField.text
    }
    
}
