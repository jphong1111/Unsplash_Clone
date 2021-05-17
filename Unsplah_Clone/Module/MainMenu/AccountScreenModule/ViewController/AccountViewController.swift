//
//  AccountViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/8/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var profileImage: UIImageView! {
        didSet {
            ReusableComponent.addRadiusForImage(profileImage)
        }
    }
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var segmentedControl: UISegmentedControl! {
        didSet {
            self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
            self.segmentedControl.selectedSegmentTintColor = Color.lightGray.color
            self.segmentedControl.backgroundColor = Color.heavyGray.color
        }
    }
    @IBOutlet private weak var tableview: UITableView! {
        didSet {
            self.tableview.dataSource = self
            self.tableview.delegate = self
            self.tableview.backgroundColor = Color.realBlack.color
            self.tableview.reloadData()
        }
    }

    lazy var viewModel = AccountViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserID()
        viewModel.fetchLikeFromServer()
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
    @IBAction private func isClicked(_ sender: UISegmentedControl) {
        self.tableview.reloadData()
    }
}
extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if viewModel.numberOfPhotoLow() == 0 {
                self.tableview.isHidden = true
            } else {
                self.tableview.isHidden = false
            }
            return viewModel.numberOfPhotoLow()

        case 1:
            if viewModel.numberOfLikeRow() == 0 {
                self.tableview.isHidden = true
            } else {
                self.tableview.isHidden = false
            }
            return viewModel.numberOfLikeRow()
            
        case 2:
            if viewModel.numberOfCollectionRow() == 0 {
                self.tableview.isHidden = true
            } else {
                self.tableview.isHidden = false
            }
            return viewModel.numberOfCollectionRow()
            
        default:
            fatalError("segment control error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.configureLikeCell(in: tableview, for: indexPath)

        case 1:
            return viewModel.configureLikeCell(in: tableview, for: indexPath)
            
        case 2:
            return viewModel.configureLikeCell(in: tableview, for: indexPath)
            
        default:
            fatalError("segment control error")
        }
    }
}

extension AccountViewController: UITableViewDelegate {
}

extension AccountViewController: AccountViewModelDelegate {
    func reload() {
        self.tableview.reloadData()
    }
    
    func show(error: AppError) {
        print(error.localizedDescription)
    }
}
