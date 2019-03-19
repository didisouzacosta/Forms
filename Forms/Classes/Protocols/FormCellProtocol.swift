//
//  FormCellProtocol.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public typealias FormCell = FormCellProtocol & UITableViewCell

public protocol FormCellProtocol: class {
    
    static var identifier: String { get }
    var reuseIdentifier: String? { get }
    
    func setup(with field: FormFieldProtocol)
    func setupContent()
    
}

extension FormCellProtocol {
    
    public var reuseIdentifier: String? {
        return type(of: self).identifier
    }
    
    public static var identifier: String {
        let defaultIdentifier = String(describing: type(of: self))
        return String(defaultIdentifier.split(separator: ".")[0])
    }
    
}
