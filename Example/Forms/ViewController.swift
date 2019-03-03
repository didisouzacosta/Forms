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
        
        let fieldA = TextFormField(value: "Adriano")
        fieldA.rules = [
            RequiredFormRule(message: "O campo 'fieldA' é obrigatório"),
            ExactLenghFormRule(exactLenght: 7, message: "O campo deve ter exatamente 7 caracters")
        ]
        
        let fieldB = DateFormField(value: Date())
        fieldB.rules.append(RequiredFormRule(message: "O campo 'Data' e obrigatório"))
        
        let fieldC = DateFormField()
        fieldC.rules.append(RequiredFormRule(message: "O campo 'Birthday' e obrigatório"))
        
        let section = SectionForm(fields: [fieldA, fieldB, fieldC])
        
        do {
            print(try section.validate())
        } catch {
            print(error)
        }
        
    }

}

