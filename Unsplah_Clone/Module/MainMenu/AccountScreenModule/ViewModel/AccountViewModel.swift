//
//  AccountViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import Firebase
import UIKit

class AccountViewModel {
    
    let db = Firestore.firestore()
    
    func getUserName(nameLabel: UILabel) {
        // guard let currentUser = Auth.auth().currentUser?.uid else { return }
        db.collection("users").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        
                        if let firstName = data["firstName"] as? String, let lastName = data["lastName"] as? String, let userID = data["uid"] as? String {
                            if userID == Auth.auth().currentUser?.uid {
                                DispatchQueue.main.async {
                                    nameLabel.text = "\(firstName) \(lastName)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
