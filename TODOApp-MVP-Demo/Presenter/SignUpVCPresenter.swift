//
//  SignUpVCPresenter.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

protocol SignUpView: SignUpVC {
    func showLoader()
    func hideLoader()
    func displayAlert(title: String, message: String)
    func canSwitchToMainState()
}

class SignUpVCPresenter {
    
    // MARK:- Properties
    private weak var view: SignUpView?
    
    // MARK:- Init
    init(view: SignUpView) {
        self.view = view
    }
    
    func validAndRegister(name: String?, email: String?, password: String?, age: String?) {
        if isValidData(name: name, email: email, password: password, age: age) {
            let user = UserData(name: name, email: email, password: password, age: Int(age!))
            register(with: user) {
                self.view?.canSwitchToMainState()
            }
        }
    }
    
}
    
extension SignUpVCPresenter {
    // MARK:- Private Methods
    private func isValidData(name: String?, email: String?, password: String?, age: String?) -> Bool {
        if let name = name, !name.isEmpty, let email = email?.trimmed, !email.isEmpty, let password = password, !password.isEmpty, let age = age, !age.isEmpty {
            
            switch name.isValidName {
            case true: break
            case false:
                view?.displayAlert(title: ValidationType.name.error.title, message: ValidationType.name.error.message)
                return false
            }
            
            switch email.isValidEmail {
            case true: break
            case false:
                view?.displayAlert(title: ValidationType.email.error.title, message: ValidationType.email.error.message)
                return false
            }
            
            switch password.isValidPassword {
            case true: break
            case false:
                view?.displayAlert(title: ValidationType.password.error.title, message: ValidationType.password.error.message)
                return false
            }
            
            switch age.isValidAge {
            case true: break
            case false:
                view?.displayAlert(title: ValidationType.age.error.title, message: ValidationType.age.error.message)
                return false
            }
            return true
        }
        
        view?.showAlert(title: "Missed data", message: "Please enter all textfields above")
        return false
    }
    
    private func register(with user: UserData, completion: @escaping () -> Void) {
        view?.showLoader()
        APIManager.register(with: user) { [weak self] (response) in
            switch response {
            case .failure(let error):
                self?.view?.displayAlert(title: "Can't sign up", message: error.localizedDescription)
            case .success(let response):
                UserDefaultsManager.shared().token = response.token
                completion()
            }
            self?.view?.hideLoader()
        }
    }
    
}
