//
//  ButomFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 06/03/19.
//

import UIKit

public enum ButtomFormType {
    case `default`
    case warning
    case danger
    
    var color: UIColor? {
        switch self {
        case .warning: return .orange
        case .danger: return .red
        default: return nil
        }
    }
}

final public class ButtomFormField: FormFieldRepresentable, FormFieldCellSelectable {
    
    public var text: String
    public var type: ButtomFormType
    public var isEnabled: Bool = true
    public var handler: () -> Void = {}
    
    public var label: String {
        return ""
    }
    
    public var placeholder: String? {
        return nil
    }
    
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
    
    public init(text: String, type: ButtomFormType = .default, handler: @escaping () -> Void) {
        self.text = text
        self.type = type
        self.handler = handler
    }
    
}

public class ButtomFormFieldCell: BaseFormFieldCell<ButtomFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void = {}
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var actionButton: UIButton?
    
    // MARK: - Public Methods
    
    public override func setup(with field: ButtomFormField?) {
        self.handler = field?.handler ?? {}
        
        actionButton?.titleLabel?.numberOfLines = 0
        actionButton?.titleLabel?.textAlignment = .center
        actionButton?.setTitle(field?.text, for: .normal)
        actionButton?.setTitleColor(field?.type.color, for: .normal)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func tap(_ outlet: UIButton) {
        handler()
    }
    
}
