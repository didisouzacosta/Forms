//
//  ViewController.swift
//  Forms
//
//  Created by adrianosouzacostaios@gmail.com on 03/01/2019.
//  Copyright (c) 2019 adrianosouzacostaios@gmail.com. All rights reserved.
//

import UIKit
import Forms

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fieldA = TextFormField()
        let fieldB = DateFormField(value: Date())
        
        let section = FormSection(fields: [fieldA, fieldB])
        
        print(section.isValid)
    }

}

