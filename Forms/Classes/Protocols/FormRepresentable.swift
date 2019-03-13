//
//  FormRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 03/03/19.
//

public protocol FormRepresentable: Validatable {
    
    var tableView: UITableView? { get }
    var sections: [FormSectionRepresentable] { get set }
    
    func indexPath(at field: FormFieldRepresentable) -> IndexPath?
    func scroll(to indexPath: IndexPath)
    func scroll(to field: FormFieldRepresentable)
    
}

extension FormRepresentable {
    
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
