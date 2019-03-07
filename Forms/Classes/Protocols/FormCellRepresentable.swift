//
//  FormCellRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public typealias FormCell = FormCellRepresentable & UITableViewCell

public protocol FormCellRepresentable: class {
    
    static var identifier: String { get }
    var reuseIdentifier: String? { get }
    
    func setup(with field: FormFieldRepresentable)
    func updateLayout()
    
}

extension FormCellRepresentable {
    
    public var reuseIdentifier: String? {
        return type(of: self).identifier
    }
    
    public static var identifier: String {
        let defaultIdentifier = String(describing: type(of: self))
        return String(defaultIdentifier.split(separator: ".")[0])
    }
    
}
