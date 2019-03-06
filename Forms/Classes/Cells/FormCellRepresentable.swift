//
//  FormCellRepresentable.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public typealias FormCell = FormCellRepresentable & UITableViewCell

public protocol FormCellRepresentable {
    
    var identifier: String { get }
    var nib: UINib { get }
    
    func setup(with field: FormFieldRepresentable)
    func updateLayout()
    
}
