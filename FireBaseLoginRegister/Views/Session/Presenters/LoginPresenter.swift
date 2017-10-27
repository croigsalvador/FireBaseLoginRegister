//
//  LoginPresenter.swift
//  ComparsApp
//
//  Created by Carlos Roig on 29/9/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol LoginPresenterView {
    
}

class LoginPresenter: Presenter {
    
    fileprivate let navigator: RegisterNavigator!
    fileprivate let loginSession: LoginUserSession
    fileprivate let emailValidator: TextValidator = EmailValidator()
    fileprivate let passwordValidator: TextValidator = PasswordValidator()
    weak var view: FormErrorsProtocol!
    
    init(navigator: RegisterNavigator, loginSession: LoginUserSession) {
        self.navigator = navigator
        self.loginSession = loginSession
    }
    
    func login(email: String?, password: String?) {
       
        if let email = email, !email.isEmpty, let password = password, !password.isEmpty {
  
        if let response =  emailValidator.validate(text: email) {
            view.showEmailValidation(errorText: response)
            return
        }
        if let response =  passwordValidator.validate(text: password) {
            view.showPasswordValidation(errorText: response)
            return
        }

        loginSession.login(email: email, password: password) { (success) in
            if success {
                self.navigator.openMainApp()
            }
        }
        } else {
            view.showLoginValidationError()
        }
    }
}

protocol BaseSessionFormPresenter {
    func validateForm()
}

extension BaseSessionFormPresenter {

}
