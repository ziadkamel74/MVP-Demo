//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    // MARK:- Properties
    var presenter: SignUpVCPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignUpVCPresenter(view: self)
    }
    
    // MARK:- UIKit Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }    

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }
    
    // MARK:- IBAction Methods
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        presenter.validAndRegister(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, age: ageTextField.text)
    }
}

extension SignUpVC {
    // MARK:- Private Methodss
    private func switchToMainState() {
        let toDoListVC = ToDoListVC.create()
        let navigationController = UINavigationController(rootViewController: toDoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
}

// MARK:- Presenter delegate
extension SignUpVC: SignUpView {
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func displayAlert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    
    func canSwitchToMainState() {
        switchToMainState()
    }
}
