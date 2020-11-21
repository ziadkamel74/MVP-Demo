//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- Properties
    var presenter: SignInPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- UIKit Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.presenter = SignInPresenter(view: signInVC)
        return signInVC
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func switchToMainState() {
        let toDoListVC = ToDoListVC.create()
        let navigationController = UINavigationController(rootViewController: toDoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    // MARK:- IBAction Methods
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        presenter.tryToLogin(with: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
