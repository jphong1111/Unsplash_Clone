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
        if let email = email.text, let password = password.text, let firstName = firstName.text, let lastName = lastName.text, let userName = userName.text {
            if !firstName.isEmpty && !lastName.isEmpty && !userName.isEmpty {
                Auth.auth().createUser(withEmail: email, password: password) { user, error in
                    if let error = error {
                        
                        print(error.localizedDescription)
                        let alert = ReusableComponent.alertMessage(title: "Signup Error", message: "Signup error try again")
                        controller.present(alert, animated: true, completion: nil)
                    } else {
                        print("Create Success")
                        guard let user = user else { fatalError("no user") }
                        self.db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "userName": userName, "uid": user.user.uid]) { error in
                            if error != nil {
                                print("data store error")
                            }
                        }
                        controller.performSegue(withIdentifier: "CompleteSignUp", sender: nil)
                    }
                }
            } else {
                let alert = ReusableComponent.alertMessage(title: "User Information Error", message: "Information invalid")
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }
}
