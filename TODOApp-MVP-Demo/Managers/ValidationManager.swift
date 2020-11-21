//
//  ValidationManager.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/21/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

enum ValidationError {
    case name, email, password, age, missedData
    
    var error: (title: String, message: String) {
        switch self {
            case .name:
            return ("Invalid Name", "Name should contain letters only, at least 3 characters and and at most 18 characters")
        case .email:
            return ("Invalid Email", "Email should be : example@mail.com")
        case .password:
            return ("Invalid Password", "Make sure password contains minimum 8 characters at least 1 uppercase alphabet, 1 lowercase alphabet, 1 number and 1 special character")
        case .age:
            return ("Invalid Age", "Age should be more than 6")
        case .missedData:
            return ("Missed data", "Please enter all textfields above")
        }
    }
}

class ValidationManager {
    // Singleton
    static let shared = ValidationManager()
    private init() {}
    
    // MARK:- Public Methods
    func tryToCathchErrors(name: String?, email: String?, password: String?, age: String?) -> (String, String)? {
        if let name = name, !name.isEmpty, let email = email?.trimmed, !email.isEmpty, let password = password, !password.isEmpty, let age = age, !age.isEmpty {
            
            switch isValidName(name) {
            case true: break
            case false:
                return ValidationError.name.error
            }
            
            switch isValidEmail(email) {
            case true: break
            case false:
                return ValidationError.email.error
            }
            
            switch isValidPassword(password) {
            case true: break
            case false:
                return ValidationError.password.error
            }
            
            switch isValidAge(age) {
            case true: break
            case false:
                return ValidationError.age.error
            }
            return nil
        }
        return ValidationError.missedData.error
    }
    
    func tryToCatchErrors(email: String?, password: String?) -> (String, String)? {
        if let email = email?.trimmed, !email.isEmpty, let password = password, !password.isEmpty {
            switch isValidEmail(email) {
            case true: break
            case false:
                return ValidationError.email.error
            }
            
            switch isValidPassword(password) {
            case true: break
            case false:
                return ValidationError.password.error
            }
            return nil
        }
        return ValidationError.missedData.error
    }
}

extension ValidationManager {    
    func isValidName(_ name: String) -> Bool {
        guard name.count > 3, name.count < 18 else { return false }
        let regularExpressionForName = "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        let testPassword = NSPredicate(format: "SELF MATCHES %@", regularExpressionForName)
        return testPassword.evaluate(with: name)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let regularExpressionForPassword = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        let testPassword = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPassword)
        return testPassword.evaluate(with: password)
    }
    
    func isValidAge(_ age: String) -> Bool {
        if let age = Int(age), age > 6 {
            return true
        }
        return false
    }
}
