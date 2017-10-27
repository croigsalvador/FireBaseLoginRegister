//
//  RegisterViewController.swift
//  ComparsApp
//
//  Created by Carlos Roig on 8/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {
    
    var presenter: RegisterPresenter!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        presenter.register(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterViewController: FormErrorsProtocol {
    func showLoginValidationError() {
        print("Empty Fields")
    }
    
    func showEmailValidation(errorText: String) {
        print(errorText)
    }
    
    func showPasswordValidation(errorText: String) {
        print(errorText)
    }
}
