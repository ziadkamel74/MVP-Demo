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
    @IBOutlet var mainView: SignUpView!
    
    // MARK:- Properties
    var presenter: SignUpPresenter!
    
    // MARK:- LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
    }

    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.presenter = SignUpPresenter(view: signUpVC)
        return signUpVC
    }
    
    // MARK:- IBAction Methods
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        presenter.tryToRegister(name: mainView.nameTextField.text, email: mainView.emailTextField.text, password: mainView.passwordTextField.text, age: mainView.ageTextField.text)
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
extension SignUpVC: SignUp {
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
