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

    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var form: Form = {
       return Form(tableView: tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fieldA = TextFormField(label: "Nome completo", placeholder: "Insira seu nome aqui")
        fieldA.rules = [
            RequiredFormRule(message: "O campo 'fieldA' é obrigatório"),
            ExactLenghFormRule(exactLenght: 7, message: "O campo deve ter exatamente 7 caracters")
        ]
        
        let fieldB = DateFormField(value: Date(), label: "Nascimento")
        fieldB.rules.append(RequiredFormRule(message: "O campo 'Data' e obrigatório"))
        
        let fieldF = SwitchFormField(value: true, label: "Está acima do peso?")
        let fieldE = SwitchFormField(label: "Tem histórico de diabetes na família?")
        
        let fieldD = SwitchFormField(label: "É hipertenso ou cadiáco?")
        fieldD.valueUpdated() { newValue, _ in
            let status = newValue ?? false
            
            fieldE.isEnabled = status
            fieldE.value = status
            
            fieldF.isEnabled = status
            fieldF.value = !status
        }
        
        let section = SectionForm(fields: fieldA, fieldB, fieldF, fieldE, fieldD)
        
        form.sections.append(contentsOf: [section])
        
        do {
            print(try form.validate())
        } catch {
            print(error)
        }
        
    }

}

