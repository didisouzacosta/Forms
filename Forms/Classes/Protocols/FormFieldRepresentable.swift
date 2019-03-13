//
//  FormFieldRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import UIKit

public protocol FormFieldRepresentable: class, RuleFieldSet, Validatable {
    
    var identifier: String { get }
    var label: String { get }
    var placeholder: String? { get }
    var cellIdentifier: String { get }
    var nib: UINib { get }
    
    var isEnabled: Bool { get set }
    
    func reload()
    func scroll()
    
}

fileprivate struct AssociatedKeys {
    static var identifierKey = "identifier.key"
    static var formKey = "form.key"
    static var tableViewKey = "tableView.key"
}

public extension FormFieldRepresentable {
    
    public var identifier: String {
        if let identifier = objc_getAssociatedObject(self, &AssociatedKeys.identifierKey) as? String {
            return identifier
        }
        
        let newUID = UUID().uuidString
        
        objc_setAssociatedObject(self, &AssociatedKeys.identifierKey, newUID, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return newUID
    }
    
    public var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self)))
    }
    
    public func isEqual<F: FormFieldRepresentable>(_ field: F?) -> Bool {
        return identifier == field?.identifier
    }
    
    public func reload() {
        tableView?.beginUpdates()
        
        (tableView?.indexPathsForVisibleRows ?? [])
            .compactMap { tableView?.cellForRow(at: $0) as? FormFieldCell }
            .forEach { $0.setupContent() }
        
        tableView?.endUpdates()
    }
    
    public func scroll() {
        form?.scroll(to: self)
    }
    
    internal var form: FormRepresentable? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formKey) as? FormRepresentable }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal weak var tableView: UITableView? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.tableViewKey) as? UITableView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.tableViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
}
