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
    private var likeDataSource = [UserData]() {
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
                                self.likeDataSource.append(UserData(author: author, url: url))
                            }
                        }
                    }
                }
            }
        }
    }
}
