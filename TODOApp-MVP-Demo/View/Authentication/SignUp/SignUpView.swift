//
//  SignUpView.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/23/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpView: UIView {

    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK:- Public Methods
    func setup() {
        setupBackGround()
        setupLabel()
        setupTextField(nameTextField, placeHolder: "Name...")
        setupTextField(emailTextField, placeHolder: "Email...", keyboardType: .emailAddress)
        setupTextField(passwordTextField, placeHolder: "Password...", isSceure: true)
        setupTextField(ageTextField, placeHolder: "Age...", keyboardType: .numberPad)
        setupSignUpButton()
    }
    
    // MARK:- UIKit Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}

// MARK:- Private Methods
extension SignUpView {
    private func setupBackGround() {
        self.backgroundColor = .systemBackground
    }
    
    private func setupLabel() {
        signUpLabel.text = "Sign Up"
        signUpLabel.textColor = .link
        signUpLabel.font = UIFont.systemFont(ofSize: 45)
        signUpLabel.textAlignment = .center
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false, keyboardType: UIKeyboardType = .default) {
        textField.placeholder = placeHolder
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.isSecureTextEntry = isSceure
    }
    
    private func setupSignUpButton() {
        signUpButton.backgroundColor = .link
        signUpButton.setTitleColor(.label, for: .normal)
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.setTitle("Sign Up", for: .normal)
    }
}
