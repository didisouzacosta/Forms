//
//  ButomFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 06/03/19.
//

import UIKit

final public class ButtomFormField: FormFieldRepresentable, FormFieldCellSelectable {
    
    public var text: String
    public var label: String = ""
    public var placeholder: String?
    public var isEnabled: Bool = true
    public var handler: () -> Void = {}
    
    public var rules: [FormRuleRepresentable] {
        get { return [] }
        set {}
    }
    
    public func validate() throws -> Bool {
        return true
    }
    
    public var cellIdentifier: String {
        return ButtomFormFieldCell.identifier
    }
    
    public init(text: String, handler: @escaping () -> Void) {
        self.text = text
        self.handler = handler
    }
    
}

public class ButtomFormFieldCell: BaseFormFieldCell<ButtomFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void = {}
    
    // MARK: - Private Variables
    // MARK: - Outlets
    
    @IBOutlet private weak var actionButton: UIButton?
    
    // MARK: - Public Methods
    
    public override func setup(with field: ButtomFormField?) {
        self.handler = field?.handler ?? {}
        actionButton?.setTitle(field?.text, for: .normal)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func tap(_ outlet: UIButton) {
        handler()
    }
    
}
