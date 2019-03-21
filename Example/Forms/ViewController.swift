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
    
    var firstSection = SectionForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameField = TextFormField(title: "Nome completo", placeholder: "Insira seu nome aqui")
        nameField.rules = [
            RequiredFormRule(message: "O campo 'Nome' é obrigatório."),
            ExactLenghFormRule(exactLenght: 7, message: "O campo nome deve ter exatamente 7 caracters")
        ]
        
        let emailField = TextFormField(title: "Email", placeholder: "Ex: email@email.com.br")
        emailField.rules = [
            RequiredFormRule(message: "O campo 'Email' é obrigatório.")
        ]
        
        let birthdayField = DateFormField(title: "Nascimento", placeholder: "Informe sua data de nascimento")
        birthdayField.rules = [
            RequiredFormRule(message: "O campo 'Aniversário' e obrigatório.")
        ]
        
        let fields = (1...3).map { index -> SwitchFormField in
            let field = SwitchFormField(title: "Label \(index)")
            field.rules = [RequiredFormRule(message: "O campo \(index) é obrigatório.")]
            return field
        }
        
        firstSection.add(fields: fields + [nameField, emailField])
        
        form.add(sections: [firstSection, firstSection, firstSection, firstSection])
        
    }
    
    private func show(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction private func scroll() {
        do {
            try form.validate()
        } catch {
            print(form.errors)
        }
    }

}

