//
//  FormErrorProtocol.swift
//  ComparsApp
//
//  Created by Carlos Roig on 10/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol FormErrorsProtocol: class {
    func showLoginValidationError()
    func showEmailValidation(errorText: String)
    func showPasswordValidation(errorText: String)
    func showNameValidation(errorText: String)
}

extension FormErrorsProtocol {
    
    func showLoginValidationError() {}
    func showEmailValidation(errorText: String) {}
    func showPasswordValidation(errorText: String) {}
    func showNameValidation(errorText: String) {}
}
