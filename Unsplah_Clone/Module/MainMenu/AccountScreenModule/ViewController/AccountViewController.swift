//
//  AccountViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/8/21.
//

import Firebase
import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    let db = Firestore.firestore()
    let viewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserID()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func getUserID() {
        viewModel.getUserName(nameLabel: userNameLabel)
    }
}
    extension AccountViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
    extension AccountViewController: UICollectionViewDelegate {
    }
