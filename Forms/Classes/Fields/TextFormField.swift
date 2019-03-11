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

public class TextFormFieldCell: BaseFormFieldCell<TextFormField> {
    
    // MARK: - Public Variables
    
    override var labelOutlet: UILabel? { return labelLabel }
    override var errorOutlet: UILabel? { return errorLabel }
    override var stackOutlet: UIStackView? { return nil }
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var labelLabel: UILabel?
    @IBOutlet private weak var errorLabel: UILabel?
    @IBOutlet private weak var valueLabel: UITextField?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        valueLabel?.text = field?.text
        valueLabel?.placeholder = field?.placeholder
    }
    
}
