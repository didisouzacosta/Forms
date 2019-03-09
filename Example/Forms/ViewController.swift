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
        
        let fieldC = DateFormField(value: Date(), label: "Nascimento")
        fieldC.rules.append(RequiredFormRule(message: "O campo 'Birthday' e obrigatório"))
        
        let fieldD = SwitchFormField(label: "É hipertenso ou cadiáco?")
        let fieldE = SwitchFormField(label: "Tem histórico de diabetes na família?")
        let fieldF = SwitchFormField(value: true, label: "Está acima do peso?")
        let fieldG = ButtomFormField(text: "Cadastrar") { print("pressionando o botão") }
        let fieldH = NumberFormField(label: "Salário", placeholder: "Informe seu salário")
        
        let fieldJ = SelectFormField(value: 0.0, label: "Idade do pai", placeholder: "Informe aqui a idade") { value in
            print(value?.valueDescription ?? "")
        }
        
        let fieldI = ButtomFormField(text: "Selecione uma cor") {
            fieldJ.value = "sdfsdf"
        }
        
        let section = SectionForm(fields: fieldJ, fieldA, fieldB, fieldG, fieldC, fieldD, fieldE, fieldF, fieldI, fieldH)
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

