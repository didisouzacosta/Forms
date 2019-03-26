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
    
    private lazy var form = Form(tableView: tableView)
    
    var firstSection = SectionForm(title: "Dados Pessoais")
    
    let nameField = TextFormField(title: "Nome completo", placeholder: "Insira seu nome aqui")
    let emailField = TextFormField(title: "Email", placeholder: "Ex: email@email.com.br")
    
    lazy var switchField: SwitchFormField = {
        let field = SwitchFormField(title: "Label \(1)")
        field.rules = [RequiredFormRule(message: "O campo \(1) é obrigatório.")]
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nameField = TextFormField(title: "Nome completo", placeholder: "Insira seu nome aqui")
//        nameField.rules = [
//            RequiredFormRule(message: "O campo 'Nome' é obrigatório."),
//            ExactLenghFormRule(exactLenght: 7, message: "O campo nome deve ter exatamente 7 caracters")
//        ]
        
//        let emailField = TextFormField(title: "Email", placeholder: "Ex: email@email.com.br")
//        emailField.rules = [
//            RequiredFormRule(message: "O campo 'Email' é obrigatório.")
//        ]
        
        let birthdayField = DateFormField(title: "Nascimento", placeholder: "Informe sua data de nascimento")
        birthdayField.rules = [
            RequiredFormRule(message: "O campo 'Aniversário' e obrigatório.")
        ]
        
        firstSection.add(fields: [switchField] + [nameField, emailField])
        
        form.add(sections: [firstSection])
        
    }
    
    private func show(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction private func scroll() {
        let isHidden = !nameField.isHidden
//        switchField.isHidden = isHidden
        nameField.isHidden = isHidden
//        emailField.isHidden = isHidden
//        try? form.validate()
    }

}

