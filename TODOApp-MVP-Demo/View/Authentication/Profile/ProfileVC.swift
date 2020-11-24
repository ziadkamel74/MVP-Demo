//
//  ProfileTableVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Ziad on 11/5/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var userImageBtn: UIButton!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK:- Properties
    var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.getUserData()
    }
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileVC)
        profileVC.presenter = ProfilePresenter(view: profileVC)
        return profileVC
    }
    
    func switchToAuthState() {
        let signInVC = SignInVC.create()
        let navigationController = UINavigationController(rootViewController: signInVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func showImageLabel() {
        imageLabel.isHidden = false
    }
    
    func hideImageLabel() {
        imageLabel.isHidden = true
    }
    
    func setImage(with data: Data) {
        userImageBtn.setImage(UIImage(data: data), for: .normal)
    }
    
    func removeImage() {
        userImageBtn.setImage(UIImage(), for: .normal)
    }
    
    func showUserInfo(_ name: String, _ email: String, _ age: String) {
        nameLabel.text = name
        ageLabel.text = age
        emailLabel.text = email
    }
    
    func configureImageLabel(with initials: String) {
        imageLabel.text = initials
    }
    
    func displayLogOutAlert() {
        let logOutAlert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        logOutAlert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] (action) in
            self?.presenter.logOut()
        }))
        
        logOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(logOutAlert, animated: true)
    }
    
    func displayDeleteAccountAlert() {
        let deleteAccAlert = UIAlertController(title: "Delete your Account", message: "Are you sure you want to delete your account?", preferredStyle: .actionSheet)
        deleteAccAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (action) in
            self?.presenter.deleteAccount()
        }))
        
        deleteAccAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(deleteAccAlert, animated: true)
    }
    
}

extension ProfileVC {
    // MARK:- Private Methods
    private func setupViews() {
        setupNavBar()
        setupImageButton()
    }
    
    private func setupImageButton() {
        userImageBtn.addTarget(self, action: #selector(didTapImageBtn), for: .touchUpInside)
        userImageBtn.layer.cornerRadius = userImageBtn.frame.width / 2
        userImageBtn.layer.masksToBounds = true
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit Info", style: .done, target: self, action: #selector(didTapEditInfo))
    }
    
    private func displayImageAlert() {
        let photoAlert = UIAlertController(title: "Profile Picture", message: nil, preferredStyle: .actionSheet)
        photoAlert.addAction(UIAlertAction(title: "Choose from Photo Library", style: .default, handler: { [weak self] (action) in
            self?.presentImagePicker()
        }))
        photoAlert.addAction(UIAlertAction(title: "Delete Picture", style: .destructive, handler: { [weak self] (action) in
            self?.presenter.deleteUserImage()
        }))
        photoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(photoAlert, animated: true)
    }
    
    private func presentImagePicker() {
        // Picker instance
        let picker = UIImagePickerController()
        // Allow image cropping
        picker.allowsEditing = true
        // Setting delegate to self, delegation design pattern require conforming protocols
        picker.delegate = self
        // Presenting the image picker
        self.present(picker, animated: true, completion: nil)
    }
    
    private func displayEditAlert() {
        let editAlert = UIAlertController(title: "Edit Info", message: nil, preferredStyle: .alert)
        editAlert.addTextField { (textField) in
            textField.placeholder = "Name..."
        }
        editAlert.addTextField { (textField) in
            textField.placeholder = "Age..."
            textField.keyboardType = .numberPad
        }
        editAlert.addTextField { (textField) in
            textField.placeholder = "Email..."
            textField.keyboardType = .emailAddress
        }
        editAlert.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { [weak self] (action) in
            
            let name = editAlert.textFields?[0].text, age = editAlert.textFields?[1].text, email = editAlert.textFields?[2].text
            self?.presenter.updateUserInfo(name: name, age: age, email: email)
            
        }))
        editAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(editAlert, animated: true)
    }
    
    // MARK:- objc Methods
    @objc private func didTapImageBtn() {
        displayImageAlert()
    }
    
    @objc private func didTapEditInfo() {
        displayEditAlert()
    }
}

// MARK:- TableView Delegate
extension ProfileVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK:- ImagePicker Delegate
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        let imageData = image?.jpegData(compressionQuality: 0.5)
        picker.dismiss(animated: true, completion: nil)
        presenter.uploadImage(with: imageData)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss picker when user cancel
        picker.dismiss(animated: true, completion: nil)
    }
}
