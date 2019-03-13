//
//  FormRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public protocol FormRepresentable: Validatable {
    
    var tableView: UITableView? { get }
    var sections: [FormSectionRepresentable] { get }
    
    mutating func add(section: FormSectionRepresentable)
    mutating func add(sections: [FormSectionRepresentable])
    mutating func remove(section: FormSectionRepresentable)
    
    func indexPath(at field: FormFieldRepresentable) -> IndexPath?
    func scroll(to indexPath: IndexPath)
    func scroll(to field: FormFieldRepresentable)
    
}

fileprivate struct AssociatedKeys {
    static var sectionsKey = "sections.key"
}

extension FormRepresentable {
    
    public var sections: [FormSectionRepresentable] {
        return _sections
    }
    
    private var _sections: [FormSectionRepresentable] {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.sectionsKey) as? [FormSectionRepresentable] ?? [] }
        set { objc_setAssociatedObject(self, &AssociatedKeys.sectionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    public mutating func add(section: FormSectionRepresentable) {
        section.fields.forEach { field in
            field.tableView = tableView
            field.form = self
        }
        
        _sections.append(section)
        
        tableView?.reloadData()
    }
    
    public mutating func add(sections: [FormSectionRepresentable]) {
        sections.forEach { add(section: $0) }
    }
    
    public mutating func remove(section: FormSectionRepresentable) {
        guard let index = sections.firstIndex(where: { $0.identifier == section.identifier }) else { return }
        _sections.remove(at: index)
        tableView?.reloadData()
    }
    
    public func indexPath(at field: FormFieldRepresentable) -> IndexPath? {
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
    
    public func scroll(to field: FormFieldRepresentable) {
        guard let indexPath = indexPath(at: field) else { return }
        scroll(to: indexPath)
    }
    
    @discardableResult
    public func validate() throws -> Bool {
        return try sections.reduce(true) { (result, section) -> Bool in
            return try section.validate() == result
        }
    }
    
}
