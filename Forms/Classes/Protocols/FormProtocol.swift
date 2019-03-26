//
//  FormProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

import UIKit

public protocol FormProtocol: Validatable {
    
    var tableView: UITableView? { get }
    
    mutating func add(section: FormSectionProtocol, position: Int?)
    mutating func add(sections: [FormSectionProtocol])
    mutating func remove(section: FormSectionProtocol)
    mutating func remove(sections: [FormSectionProtocol])
    
    func indexPath(at field: FormFieldProtocol) -> IndexPath?
    func scroll(to indexPath: IndexPath)
    func scroll(to field: FormFieldProtocol)
    func reloadData()
    
}

fileprivate struct AssociatedKeys {
    static var sectionsKey = "sections.key"
}

extension FormProtocol {
    
    public var sections: [FormSectionProtocol] {
        return _sections
    }
    
    public var isValid: Bool {
        return errors.isEmpty
    }
    
    public var errors: [Error] {
        return sections.flatMap { $0.fields.flatMap { $0.errors } }
    }
    
    private var _sections: [FormSectionProtocol] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.sectionsKey) as? [FormSectionProtocol] ?? [] }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.sectionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            reloadData()
        }
    }
    
    internal func visibleFieldsIn(section: Int) -> [FormFieldProtocol] {
        return sections[section].fields.filter { !$0.isHidden }
    }
    
    public mutating func add(section: FormSectionProtocol, position: Int? = nil) {
        var section = section
        section.form = self
        section.fields.forEach { tableView?.register($0.nib, forCellReuseIdentifier: $0.cellIdentifier) }
        
        if let position = position, position >= 0, position <= _sections.count - 1 {
            _sections.insert(section, at: position)
        } else {
            _sections.append(section)
        }
    }
    
    public mutating func add(sections: [FormSectionProtocol]) {
        sections.forEach { add(section: $0) }
    }
    
    public mutating func remove(section: FormSectionProtocol) {
        guard let index = sections.firstIndex(where: { $0.identifier == section.identifier }) else { return }
        _sections.remove(at: index)
    }
    
    public mutating func remove(sections: [FormSectionProtocol]) {
        sections.forEach { remove(section: $0) }
    }
    
    public func indexPath(at field: FormFieldProtocol) -> IndexPath? {
        var indexPath: IndexPath?
        
        sections.enumerated().forEach { sectionIndex, section in
            if let fieldIndex = section.fields.firstIndex(where: { $0.identifier == field.identifier }) {
                indexPath = IndexPath(row: fieldIndex, section: sectionIndex)
                return
            }
        }
        
        return indexPath
    }
    
    public func scroll(to indexPath: IndexPath) {
        tableView?.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    public func scroll(to field: FormFieldProtocol) {
        guard let indexPath = indexPath(at: field), field.isHidden == false else { return }
        scroll(to: indexPath)
    }
    
    public func reloadData() {
        tableView?.reloadData()
    }
    
    public func validate() throws {
        if let error = sections.flatMap ({ $0.fields }).compactMap ({ field -> Error? in
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
