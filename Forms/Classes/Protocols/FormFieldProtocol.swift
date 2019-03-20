//
//  FormFieldProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import UIKit

public protocol FormFieldProtocol: class, RuleFieldSetProtocol, FormIdentifiable {
    
    var title: String { get }
    var placeholder: String? { get }
    var cellIdentifier: String { get }
    var nib: UINib { get }
    
    var isEnabled: Bool { get set }
    var isValid: Bool { get }
    var errors: [Error] { get }
    
    func reload()
    func scroll()
    
}

fileprivate struct AssociatedKeys {
    static var formSectionKey = "formSection.key"
    static var showErrosKey = "showErros.key"
}

public extension FormFieldProtocol {
    
    internal var section: FormSectionProtocol? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formSectionKey) as? FormSectionProtocol }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formSectionKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    internal var showErros: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.showErrosKey) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.showErrosKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    public var isValid: Bool {
        return errors.isEmpty
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
