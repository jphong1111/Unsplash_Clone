//
//  AccountViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import Firebase
import UIKit

protocol AccountViewModelDelegate: AnyObject {
    func reload()
    func show(error: AppError)
}
class AccountViewModel {
    
    let db = Firestore.firestore()
    
    private var photoDataSource = [UserPhotoData]() {
        didSet {
            self.delegate?.reload()
        }
    }
    private var likeDataSource = [UserLikeData]() {
        didSet {
            self.delegate?.reload()
        }
    }
    private var collectionDataSource = [UserCollectionData]() {
        didSet {
            self.delegate?.reload()
        }
    }
    
    weak var delegate: AccountViewModelDelegate?
    
    init(delegate: AccountViewModelDelegate) {
        self.delegate = delegate
    }
    func logIn(emailTextField: UITextField, passwordTextField: UITextField, viewController: UIViewController) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            emailTextField.text = ""
            passwordTextField.text = ""
            Auth.auth().signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    print(error)
                    let alert = ReusableComponent.alertMessage(title: "Login Error", message: "Password or ID is invalid try again")
                    viewController.present(alert, animated: true, completion: nil)
                } else {
                    viewController.performSegue(withIdentifier: "CompletedLogIn", sender: nil)
                }
            }
        }
    }
    
    func numberOfPhotoLow() -> Int {
        photoDataSource.count
    }
    func numberOfLikeRow() -> Int {
        likeDataSource.count
    }
    func numberOfCollectionRow() -> Int {
        collectionDataSource.count
    }
    func configureLikeCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AccountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell") as? AccountTableViewCell
        else { fatalError("not find") }
        let photo = likeDataSource[indexPath.row]
        cell.configure(author: photo.author, photoImage: photo.url)
        return cell
    }
    func configureCollectionCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AccountTableViewCollectionCell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCollectionCell") as? AccountTableViewCollectionCell
        else { fatalError("not find") }
        let photo = collectionDataSource[indexPath.row]
        cell.configure(photoImage: photo.photoUrl, author: photo.author)
        return cell
    }
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
    func fetchLikeFromServer() {
        db.collection("photoUrl").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let author = data["author"] as? String, let url = data["url"] as? String, let userID = data["uid"] as? String {
                            if userID == Auth.auth().currentUser?.uid {
                                self.likeDataSource.append(UserLikeData(author: author, url: url))
                                self.likeDataSource = self.likeDataSource.removingDuplicates()
                            }
                        }
                    }
                }
            }
        }
    }
    func fetchCollectionFromServer() {
        db.collection("collectionUrl").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let author = data["author"] as? String, let url = data["url"] as? String, let userID = data["uid"] as? String {
                            if userID == Auth.auth().currentUser?.uid {
                                self.collectionDataSource.append(UserCollectionData(photoUrl: url, author: author))
                                self.collectionDataSource = self.collectionDataSource.removingDuplicates()
                            }
                        }
                    }
                }
            }
        }
    }
}
