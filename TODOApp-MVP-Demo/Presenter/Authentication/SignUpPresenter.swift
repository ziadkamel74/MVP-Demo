//
//  SignUpVCPresenter.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

protocol SignUp: SignUpVC {
    func showLoader()
    func hideLoader()
    func displayAlert(title: String, message: String)
    func canSwitchToMainState()
}

class SignUpPresenter {
    
    // MARK:- Properties
    private weak var view: SignUp?
    
    // MARK:- Init
    init(view: SignUp) {
        self.view = view
    }
    
    // MARK:- Public Methods
    func tryToRegister(name: String?, email: String?, password: String?, age: String?) {
        if isValidData(name, email, password, age) {
            let user = UserData(name: name, email: email, password: password, age: Int(age!))
            register(with: user) {
                self.view?.canSwitchToMainState()
            }
        }
    }
}

// MARK:- Private Methods
extension SignUpPresenter {
    private func isValidData(_ name: String?, _ email: String?, _ password: String?, _ age: String?) -> Bool {
        if let validationError = ValidationManager.shared.tryToCathchErrors(name: name, email: email, password: password, age: age) {
            view?.displayAlert(title: validationError.0, message: validationError.1)
            return false
        }
        return true
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
