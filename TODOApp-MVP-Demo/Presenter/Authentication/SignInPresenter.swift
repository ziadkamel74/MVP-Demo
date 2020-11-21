//
//  SignInPresenter.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/21/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class SignInPresenter {
    // MARK:- Properties
    private weak var view: SignInVC?
    
    // MARK:- Init
    init(view: SignInVC) {
        self.view = view
    }
    
    // MARK:- Public Methods
    func tryToLogin(with email: String?, password: String?) {
        if isValidData(email, password) {
            let user = UserData(email: email, password: password)
            login(with: user)
        }
    }
    
}

// MARK:- Private Methods
extension SignInPresenter {
    private func isValidData(_ email: String?, _ password: String?) -> Bool {
        if let error = ValidationManager.shared.tryToCatchErrors(email: email, password: password) {
            view?.showAlert(title: error.0, message: error.1)
            return false
        }
        return true
    }
    
    private func login(with user: UserData) {
        view?.showLoader()
        APIManager.login(with: user) { [weak self] (response) in
            switch response {
            case .failure(let error):
                self?.view?.showAlert(title: "Can't log in", message: error.localizedDescription)
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                self?.view?.switchToMainState()
            }
            self?.view?.hideLoader()
        }
    }
}
