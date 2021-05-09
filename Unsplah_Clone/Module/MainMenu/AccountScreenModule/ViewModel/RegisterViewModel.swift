//
//  RegisterViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/8/21.
//

import Firebase
import UIKit

class RegisterViewModel {
    
    let db = Firestore.firestore()
    
    func registerAccount(email: UITextField, password: UITextField, firstName: UITextField, lastName: UITextField, userName: UITextField, controller: UIViewController) {
        if let email = email.text, let password = password.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let error = error {
                    print(error)
                } else {
                    print("Create Success")
                    guard let firstName = firstName.text, let lastName = lastName.text, let userName = userName.text else { fatalError("user info invalid") }
                    self.db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "userName": userName]) { error in
                        if error != nil {
                            print("data store error")
                        }
                    }
                    controller.performSegue(withIdentifier: "CompleteSignUp", sender: nil)
                }
            }
        }
    }
}