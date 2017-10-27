//
//  LoginViewController.swift
//  ComparsApp
//
//  Created by Carlos Roig on 29/9/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {

    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter.login(email: emailTextField.text, password: passwordTextField.text)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: FormErrorsProtocol {
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
