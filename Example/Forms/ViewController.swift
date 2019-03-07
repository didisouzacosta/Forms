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
        
        let fieldA = TextFormField(label: "Nome", placeholder: "Insira seu nome aqui")
        fieldA.rules = [
            RequiredFormRule(message: "O campo 'fieldA' é obrigatório"),
            ExactLenghFormRule(exactLenght: 7, message: "O campo deve ter exatamente 7 caracters")
        ]
        
        let fieldB = DateFormField(value: Date(), label: "Nascimento") { print("Primeiro field de date") }
        fieldB.rules.append(RequiredFormRule(message: "O campo 'Data' e obrigatório"))
        
        let fieldC = DateFormField(value: Date(), label: "Nascimento") { print("Segundo field de date") }
        fieldC.rules.append(RequiredFormRule(message: "O campo 'Birthday' e obrigatório"))
        
        let fieldD = SwitchFormField(label: "É hipertenso ou cadiáco?")
        let fieldE = SwitchFormField(label: "Tem histórico de diabetes na família?")
        let fieldF = SwitchFormField(value: true, label: "Está acima do peso?")
        let fieldG = ButtomFormField(text: "Cadastrar") { print("pressionando o botão") }
        
        let section = SectionForm(fields: fieldA, fieldB, fieldG, fieldC, fieldD, fieldE, fieldF, fieldG, fieldG, fieldG)
        let sectionB = SectionForm(fields: fieldA, fieldA)
        let sectionC = SectionForm(fields: fieldB, fieldB, fieldB, fieldB, fieldB, fieldB)
        let sectionD = SectionForm(fields: fieldA, fieldA, fieldB, fieldB, fieldB, fieldB, fieldB, fieldB)
        
        form.sections.append(contentsOf: [section, sectionB, sectionC, sectionD, section, sectionB, sectionC, sectionD])
        
        do {
            print(try form.validate())
        } catch {
            print(error)
        }
        
    }

}

