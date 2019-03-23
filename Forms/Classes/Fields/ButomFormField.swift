//
//  ButomFormField.swift
//  Forms
//
//  Created by Adriano Souza Costa on 06/03/19.
//

import UIKit

public enum ButtomFormType {
    case normal
    case warning
    case danger
    case submit
    
    var color: UIColor? {
        switch self {
        case .warning: return .orange
        case .danger: return .red
        case .submit: return .color(red: 5, green: 122, blue: 255)
        default: return .darkGray
        }
    }
    
}

final public class ButtomFormField: FormFieldProtocol, FormFieldCellSelectable {
    
    public var text: String
    public var type: ButtomFormType
    public var acessory: UITableViewCell.AccessoryType
    public var isEnabled: Bool = true
    public var isVisible: Bool = true
    public var errors: [Error] = []
    public var handler: () -> Void = {}
    
    public var title: String {
        return ""
    }
    
    public var placeholder: String? {
        return nil
    }
    
    public var rules: [FormRuleProtocol] {
        get { return [] }
        set {}
    }
    
    public func validate() throws {}
    
    public var cellIdentifier: String {
        return ButtomFormFieldCell.identifier
    }
    
    public init(text: String, type: ButtomFormType = .submit, acessory: UITableViewCell.AccessoryType = .none, handler: @escaping () -> Void) {
        self.text = text
        self.type = type
        self.acessory = acessory
        self.handler = handler
    }
    
}

public class ButtomFormFieldCell: BaseFormFieldCell<ButtomFormField>, FormFieldCellSelectable {
    
    // MARK: - Public Variables
    
    public var handler: () -> Void = {}
    
    override var titleLabel: UILabel? { return _titleLabel }
    
    // MARK: - Private Variables
    // MARK: Outlets
    
    @IBOutlet private weak var _titleLabel: UILabel?
    
    // MARK: - Public Methods
    
    public override func setupContent() {
        super.setupContent()
        
        guard let field = field else { return }
        
        self.handler = field.handler
        
        titleLabel?.textAlignment = field.acessory == .none ? .center : .left
        titleLabel?.text = field.text
        titleLabel?.textColor = field.type.color
        
        accessoryType = field.acessory
    }
    
}
