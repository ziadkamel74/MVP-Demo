//
//  SignInView.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/23/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInView: UIView {
    // MARK:- Outlets
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    // MARK:- Public Methods
    func setup() {
        setupBackGround()
        setupLabel()
        setupTextField(emailTextField, placeHolder: "Email...", keyboardType: .emailAddress)
        setupTextField(passwordTextField, placeHolder: "Password...", isSceure: true)
        setupButton(loginButton, title: "LOGIN")
        setupButton(createAccountButton, title: "Create Account")
    }
    
    // MARK:- UIView Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

// MARK:- Private Methods
extension SignInView {
    private func setupBackGround() {
        self.backgroundColor = .systemBackground
    }
    
    private func setupLabel() {
        signInLabel.text = "Sign In"
        signInLabel.textColor = .link
        signInLabel.font = UIFont.systemFont(ofSize: 45)
        signInLabel.textAlignment = .center
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false, keyboardType: UIKeyboardType = .default) {
        textField.placeholder = placeHolder
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.isSecureTextEntry = isSceure
    }
    
    private func setupButton(_ button: UIButton, title: String) {
        button.backgroundColor = .link
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = button.frame.height / 2
        button.setTitle(title, for: .normal)
    }
}
