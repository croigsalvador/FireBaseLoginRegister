//
//  RegisterPresenter.swift
//  ComparsApp
//
//  Created by Carlos Roig on 8/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation


class RegisterPresenter: Presenter {
    
    fileprivate let navigator: RegisterNavigator!
    fileprivate let registerSession: RegisterUserSession
    var view: FormErrorsProtocol!
    fileprivate let emailValidator: TextValidator = EmailValidator()
    fileprivate let passwordValidator: TextValidator = PasswordValidator()
    fileprivate let nameValidator: TextValidator = NameValidator()
    
    init(navigator: RegisterNavigator, registerSession: RegisterUserSession) {
        self.navigator = navigator
        self.registerSession = registerSession
    }
    
    func register(name:String?, email: String?, password: String?) {
        if let email = email, !email.isEmpty, let password = password, !password.isEmpty, let name = name, !name.isEmpty {
            if let response =  emailValidator.validate(text: email) {
                view.showEmailValidation(errorText: response)
                return
            }
            if let response =  passwordValidator.validate(text: password) {
                view.showPasswordValidation(errorText: response)
                return
            }
            if let response =  nameValidator.validate(text:name) {
                view.showNameValidation(errorText: response)
                return
            }
            registerSession.register(name: name, email: email, password: password) { (success) in
                if success {
                    self.navigator.openMainApp()
                }
            }
        } else {
            view.showLoginValidationError()
        }
        
    }
    
}


