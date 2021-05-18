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
    @IBOutlet private weak var passwordTextfield: UITextField! {
        didSet {
            StringColor.changeColor(textField: passwordTextfield, text: "Password", color: .gray)
        }
    }
    
    @IBOutlet private weak var logInContainer: UIView! {
        didSet {
            ReusableComponent.addRadiusForButton(logInContainer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction private func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextfield.text {
            emailTextField.text = ""
            passwordTextfield.text = ""
                    Auth.auth().signIn(withEmail: email, password: password) { _, error in
                        if let error = error {
                            print(error)
                            let alert = ReusableComponent.alertMessage(title: "Login Error", message: "Password or ID is invalid try again")
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            self.performSegue(withIdentifier: "CompleteLogIn", sender: nil)
                        }
                    }
                }
    }
}
