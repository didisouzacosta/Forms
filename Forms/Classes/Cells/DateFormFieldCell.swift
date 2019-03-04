//
//  DateFormFieldCell.swift
//  Forms
//
//  Created by Adriano Souza Costa on 04/03/19.
//

import UIKit

public class DateFormFieldCell: BaseFormFieldCell<DateFormField> {
    
    @IBOutlet private weak var detailLabel: UILabel?
    
    public override func setup(with field: DateFormField?) {
        guard let date = field?.date else { return }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        detailLabel?.text = formatter.string(from: date)
    }
    
}
