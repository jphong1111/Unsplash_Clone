//
//  RegisterViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet private weak var firstNameTextField: UITextField! {
        didSet {
            StringColor.changeColor(textField: firstNameTextField, text: "First name", color: .gray)
        }
    }
    @IBOutlet private weak var lastNameTextField: UITextField! {
        didSet {
            StringColor.changeColor(textField: lastNameTextField, text: "Last name", color: .gray)
        }
    }
    @IBOutlet private weak var userNameTextField: UITextField! {
        didSet {
            StringColor.changeColor(textField: userNameTextField, text: " Username", color: .gray)
        }
    }
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            StringColor.changeColor(textField: emailTextField, text: "Email", color: .gray)
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            StringColor.changeColor(textField: passwordTextField, text: "Password", color: .gray)
        }
    }
    @IBOutlet private weak var signUpButton: UIButton! {
        didSet {
            self.signUpButton.layer.cornerRadius = 5
        }
    }
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Login"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = Color.realBlack.color
    }
    
    @IBAction private func openTerms(_ sender: UIButton) {
        ReusableComponent.linkToUrl(url: "https://unsplash.com/terms")
    }
    @IBAction private func openPolicy(_ sender: UIButton) {
        ReusableComponent.linkToUrl(url: "https://unsplash.com/privacy")
    }
    
    @IBAction private func registerPressed(_ sender: UIButton) {
        viewModel.registerAccount(email: emailTextField, password: passwordTextField, firstName: firstNameTextField, lastName: lastNameTextField, userName: userNameTextField, controller: self)
    }
}
