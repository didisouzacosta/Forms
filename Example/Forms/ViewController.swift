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
        
        let fieldA = TextFormField(value: "a")
        fieldA.rules = [
            RequiredFormRule(message: "O campo é obrigatório"),
            ExactLenghFormRule(exactLenght: 7, message: "O campo deve ter exatamente 7 caracters")
        ]
        
        do {
            print(try fieldA.validate())
        } catch {
            print(error.localizedDescription)
        }
        
    }

}

