//
//  LogInPopUpViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/17/21.
//

import Firebase
import UIKit

class LogInPopUpViewController: UIViewController {

    @IBOutlet private weak var logInViewContainer: UIView! {
        didSet {
            ReusableComponent.addMoreRadiusForView(self.logInViewContainer)
        }
    }
    @IBOutlet private weak var cancelButton: UIButton!
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
    @IBOutlet private weak var pressedJoin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func dismissLogInScreen(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func logInPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            emailTextField.text = ""
            passwordTextField.text = ""
            Auth.auth().signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    print(error)
                    let alert = ReusableComponent.alertMessage(title: "Login Error", message: "Password or ID is invalid try again")
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
