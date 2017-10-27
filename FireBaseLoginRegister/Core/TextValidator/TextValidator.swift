//
//  TextValidator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 10/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol TextValidator {
    func validate(text:String) -> String?
}

struct EmailValidator: TextValidator {
    func validate(text:String) -> String? {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with:text) ? nil : "Email inválido"
    }
}

struct PasswordValidator: TextValidator {
    func validate(text:String) -> String? {
        if text.characters.count < 6 {
            return "Mínimo 6 caracteres"
        }
        return nil
    }
}

struct NameValidator: TextValidator {
    func validate(text:String) -> String? {
        if text.characters.count < 4 {
            return "Mínimo 4 letras"
        }
        return nil
    }
}
