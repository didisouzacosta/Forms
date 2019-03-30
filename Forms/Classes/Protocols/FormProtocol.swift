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
    
    func scroll(to indexPath: IndexPath)
    func scroll(to field: FormFieldProtocol)
    func reloadData()
    
}

fileprivate struct AssociatedKeys {
    static var sectionsKey = "sections.key"
    static var visibilityManagerKey = "visibilityManager.key"
}

extension FormProtocol {
    
    public var visibleCells: [FormCell] {
        return tableView?.visibleCells as? [FormCell] ?? []
    }
    
    public var sections: [FormSectionProtocol] {
        return _sections
    }
    
    public var isValid: Bool {
        return errors.isEmpty
    }
    
    public var errors: [Error] {
        return sections.flatMap { $0.fields.flatMap { $0.errors } }
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
    
    public func scroll(to indexPath: IndexPath) {
        tableView?.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    
    public func scroll(to field: FormFieldProtocol) {
        guard let indexPath = indexPath(at: field), field.isHidden == false else { return }
        scroll(to: indexPath)
    }
    
    public func reloadData() {
        sections.flatMap { $0.fields }.forEach { $0.reload() }
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
    
    private var _sections: [FormSectionProtocol] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.sectionsKey) as? [FormSectionProtocol] ?? [] }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.sectionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            reloadData()
        }
    }
    
    private var visibilityManager: VisibilityManager? {
        get {
            if let visibilityManager = objc_getAssociatedObject(self, &AssociatedKeys.visibilityManagerKey) as? VisibilityManager {
                return visibilityManager
            } else if let tableView = tableView {
                let visibilityManager = VisibilityManager(tableView: tableView, fields: sections.flatMap { $0.fields })
                objc_setAssociatedObject(self, &AssociatedKeys.visibilityManagerKey, visibilityManager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return visibilityManager
            } else {
                return nil
            }
        }
    }
    
    internal func visibleFields(at section: Int) -> [FormFieldProtocol] {
        return sections[section].fields.filter { !$0.isHidden }
    }
    
    internal func visibleField(at indexPath: IndexPath) -> FormFieldProtocol {
        return visibleFields(at: indexPath.section)[indexPath.row]
    }
    
    internal func toggleVisibility() {
        visibilityManager?.toggleVisibility()
    }
    
    internal func indexPath(at field: FormFieldProtocol) -> IndexPath? {
        var indexPath: IndexPath?
        
        sections.enumerated().forEach { sectionIndex, section in
            if let fieldIndex = section.fields.firstIndex(where: { $0.identifier == field.identifier }) {
                indexPath = IndexPath(row: fieldIndex, section: sectionIndex)
                return
            }
        }
        
        return indexPath
    }
    
}

class VisibilityManager: NSObject {

    // MARK: - Private Variables

    private weak var tableView: UITableView?
    private var fields: [FormFieldProtocol] = []

    // MARK: - Life Cycle

    init(tableView: UITableView, fields: [FormFieldProtocol]) {
        self.tableView = tableView
        self.fields = fields
    }

    // MARK: - Public Methods

    func toggleVisibility() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(adjustVibility), object: nil)
        perform(#selector(adjustVibility), with: nil, afterDelay: 0.1)
    }

    // MARK: - Private Methods

    @objc private func adjustVibility() {
        let sections = fields
            .compactMap({ $0.indexPath })
            .reduce([]) { (result, indexPath) -> [Int] in
                if result.contains(where: { $0 == indexPath.section }) {
                    return result
                } else {
                    return result + [indexPath.section]
                }
        }
        
        tableView?.beginUpdates()
        tableView?.reloadSections(IndexSet(sections), with: .none)
        tableView?.endUpdates()
    }

}
