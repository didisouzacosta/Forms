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
    
    var firstSection = SectionForm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameField = TextFormField(label: "Nome completo", placeholder: "Insira seu nome aqui")
        nameField.rules = [
            RequiredFormRule(message: "O campo 'Nome' é obrigatório."),
            ExactLenghFormRule(exactLenght: 7, message: "O campo deve ter exatamente 7 caracters")
        ]
        
        let emailField = TextFormField(label: "Email", placeholder: "Ex: email@email.com.br")
        emailField.rules = [
            RequiredFormRule(message: "O campo 'Email' é obrigatório.")
        ]
        
        let birthdayField = DateFormField(label: "Nascimento", placeholder: "Informe sua data de nascimento")
        birthdayField.rules = [
            RequiredFormRule(message: "O campo 'Aniversário' e obrigatório.")
        ]
        
        let fields = (1...3).map { index in
            return SwitchFormField(label: "Label \(index)")
        }
        
        firstSection.add(fields: fields)
        
        form.add(sections: [firstSection])
        
    }
    
    private func show(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction private func scroll() {
        let buttomField = ButtomFormField(text: "Cadastrar", type: .submit) { [weak self] in
            do {
                try self?.form.validate()
            } catch {
                self?.show(error: error)
            }
        }
        
        firstSection.add(field: buttomField)
    }

}

