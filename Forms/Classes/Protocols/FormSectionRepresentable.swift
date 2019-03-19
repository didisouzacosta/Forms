//
//  FormSectionRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 01/03/19.
//

import Foundation

public protocol FormSectionRepresentable: FormIdentifiable, Validatable {
    
    mutating func add(field: FormFieldRepresentable, position: Int?)
    mutating func add(fields: [FormFieldRepresentable])
    mutating func remove(field: FormFieldRepresentable)
    mutating func remove(fields: [FormFieldRepresentable])
    
}

fileprivate struct AssociatedKeys {
    static var formKey = "form.key"
    static var fieldsKey = "fields.key"
}

extension FormSectionRepresentable {
    
    internal var form: FormRepresentable? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.formKey) as? FormRepresentable }
        set { objc_setAssociatedObject(self, &AssociatedKeys.formKey, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
    
    private var _fields: [FormFieldRepresentable] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.fieldsKey) as? [FormFieldRepresentable] ?? [] }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fieldsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            form?.reloadData()
        }
    }
    
    public var fields: [FormFieldRepresentable] {
        return _fields
    }
    
    public mutating func add(field: FormFieldRepresentable, position: Int? = nil) {
        field.section = self
        form?.tableView?.register(field.nib, forCellReuseIdentifier: field.cellIdentifier)
        
        if let position = position, position >= 0, position <= _fields.count - 1 {
            _fields.insert(field, at: position)
        } else {
            _fields.append(field)
        }
    }
    
    public mutating func add(fields: [FormFieldRepresentable]) {
        fields.forEach { add(field: $0) }
    }
    
    public mutating func remove(field: FormFieldRepresentable) {
        guard let index = fields.firstIndex(where: { $0.identifier == field.identifier }) else { return }
        _fields.remove(at: index)
    }
    
    public mutating func remove(fields: [FormFieldRepresentable]) {
        fields.forEach { remove(field: $0) }
    }
    
    @discardableResult
    public func validate() throws -> Bool {
        return try fields.reduce(true) { (result, field) -> Bool in
            return try field.validate() == result
        }
    }
    
}
