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
    
    var isHidden: Bool { get set }
    var isEnabled: Bool { get set }
    var isValid: Bool { get }
    var errors: [Error] { get }
    
    func reload()
    func scroll()
    
}

fileprivate struct AssociatedKeys {
    static var formSectionKey = "formSection.key"
    static var showErrosKey = "showErros.key"
    static var isHiddenKey = "isHidden.key"
}

public extension FormFieldProtocol {
    
    var isHidden: Bool {
        get { return _isHidden }
        set { _isHidden = newValue }
    }
    
    var isValid: Bool {
        return errors.isEmpty
    }
    
    var nib: UINib {
        return UINib(nibName: cellIdentifier, bundle: Bundle(for: type(of: self)))
    }
    
    func reload() {
        let tableView = section?.form?.tableView
        
        tableView?.beginUpdates()
        
        (tableView?.indexPathsForVisibleRows ?? [])
            .compactMap { tableView?.cellForRow(at: $0) as? FormFieldCell }
            .forEach { $0.setupContent() }
        
        tableView?.endUpdates()
    }
    
    func scroll() {
        section?.form?.scroll(to: self)
    }
    
    internal var section: FormSectionProtocol? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formSectionKey) as? FormSectionProtocol }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formSectionKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    internal var showErros: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.showErrosKey) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &AssociatedKeys.showErrosKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    internal var _isHidden: Bool {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.isHiddenKey) as? Bool ?? false }
        set {
            guard newValue != _isHidden else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.isHiddenKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            toggleVisibility(newValue)
        }
    }
    
    internal func toggleVisibility(_ isHidden: Bool) {
        guard let tableView = section?.form?.tableView,
            let indexPath = section?.form?.indexPath(at: self) else { return }
        
        tableView.beginUpdates()
        
        if isHidden {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
            
        tableView.endUpdates()
    }
    
}
