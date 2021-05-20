//
//  LoginViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {

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
    
    @IBOutlet private weak var logInContainer: UIView! {
        didSet {
            ReusableComponent.addRadiusForView(logInContainer)
        }
    }
    
    lazy var accountViewModel = AccountViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "CompleteLogIn", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        accountViewModel.logIn(emailTextField: emailTextField, passwordTextField: passwordTextField, viewController: self)
    }
}
extension LoginViewController: AccountViewModelDelegate {
    func reload() {
    }
    
    func show(error: AppError) {
    }
}
