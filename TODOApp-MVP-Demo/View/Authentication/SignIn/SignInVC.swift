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
    @IBOutlet var mainView: SignInView!
    
    // MARK:- Properties
    var presenter: SignInPresenter!
    
    // MARK:- LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setup()
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
        presenter.tryToLogin(with: mainView.emailTextField.text, password: mainView.passwordTextField.text)
    }
    
    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
