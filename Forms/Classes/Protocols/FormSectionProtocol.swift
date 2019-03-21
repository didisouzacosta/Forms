//
//  FormSectionProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import Foundation

public protocol FormSectionProtocol: FormIdentifiable, Validatable {
    
    var title: String? { get }
    var footer: String? { get }
    var headerView: UIView? { get }
    var footerView: UIView? { get }
    
    mutating func add(field: FormFieldProtocol, position: Int?)
    mutating func add(fields: [FormFieldProtocol])
    mutating func remove(field: FormFieldProtocol)
    mutating func remove(fields: [FormFieldProtocol])
    
}

fileprivate struct AssociatedKeys {
    static var formKey = "form.key"
    static var fieldsKey = "fields.key"
}

extension FormSectionProtocol {
    
    internal var form: FormProtocol? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formKey) as? FormProtocol }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    public var isValid: Bool {
        return errors.isEmpty
    }
    
    public var errors: [Error] {
        return fields.compactMap { field -> Error? in
            do {
                try field.validate()
                return nil
            } catch {
                return error
            }
        }
    }
    
    private var _fields: [FormFieldProtocol] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.fieldsKey) as? [FormFieldProtocol] ?? [] }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fieldsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            form?.reloadData()
        }
    }
    
    public var fields: [FormFieldProtocol] {
        return _fields
    }
    
    public mutating func add(field: FormFieldProtocol, position: Int? = nil) {
        field.section = self
        form?.tableView?.register(field.nib, forCellReuseIdentifier: field.cellIdentifier)
        
        if let position = position, position >= 0, position <= _fields.count - 1 {
            _fields.insert(field, at: position)
        } else {
            _fields.append(field)
        }
    }
    
    public mutating func add(fields: [FormFieldProtocol]) {
        fields.forEach { add(field: $0) }
    }
    
    public mutating func remove(field: FormFieldProtocol) {
        guard let index = fields.firstIndex(where: { $0.identifier == field.identifier }) else { return }
        _fields.remove(at: index)
    }
    
    public mutating func remove(fields: [FormFieldProtocol]) {
        fields.forEach { remove(field: $0) }
    }
    
    public func validate() throws {
        if let error = fields.compactMap({ field -> Error? in
            do {
                try field.validate()
                return nil
            } catch {
                return error
            }
        }).first {
            throw error
        }
    }
    
}
