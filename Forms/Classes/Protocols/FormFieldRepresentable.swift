//
//  FormFieldRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import UIKit

public protocol FormFieldRepresentable: class, RuleFieldSet, Validatable, FormIdentifiable {
    
    var label: String { get }
    var placeholder: String? { get }
    var cellIdentifier: String { get }
    var nib: UINib { get }
    
    var isEnabled: Bool { get set }
    
    func reload()
    func scroll()
    
}

fileprivate struct AssociatedKeys {
    static var formSectionKey = "formSection.key"
}

public extension FormFieldRepresentable {
    
    internal var section: FormSectionRepresentable? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formSectionKey) as? FormSectionRepresentable }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formSectionKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    public var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self)))
    }
    
    public func reload() {
        let tableView = section?.form?.tableView
        
        tableView?.beginUpdates()
        
        (tableView?.indexPathsForVisibleRows ?? [])
            .compactMap { tableView?.cellForRow(at: $0) as? FormFieldCell }
            .forEach { $0.setupContent() }
        
        tableView?.endUpdates()
    }
    
    public func scroll() {
        section?.form?.scroll(to: self)
    }
    
}
