//
//  LoginViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Firebase
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    
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
                    Auth.auth().signIn(withEmail: email, password: password) { _, error in
                        if let error = error {
                            print(error)
                            let alert = UIAlertController(title: "Login Error", message: "Password or ID is invalid try again", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                            alert.addAction(alertAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
    }
}
