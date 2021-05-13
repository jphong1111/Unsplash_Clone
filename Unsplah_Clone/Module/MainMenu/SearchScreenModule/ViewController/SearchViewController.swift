//
//  SearchViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/10/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            self.searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(UINib(nibName: "SearchCollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCollectionTableViewCell")
            self.tableView.register(UINib(nibName: "SearchUserTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchUserTableViewCell")
            self.tableView.reloadData()
        }
    }
    @IBOutlet private weak var settingButton: UIButton!
    @IBOutlet private weak var segmentControl: UISegmentedControl!

    lazy var viewModel = SearchViewModel(delegate: self)
    
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
    
    @IBAction private func onChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            settingButton.isHidden = false
        } else {
            settingButton.isHidden = true
        }
        self.tableView.reloadData()
    }
}
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return viewModel.numberOfPhotos()

        case 1:
            return viewModel.numberOfCollections()
            
        case 2:
            return viewModel.numberOfUsers()
            
        default:
            fatalError("segment control error")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return viewModel.configurePhotoCell(in: tableView, for: indexPath)

        case 1:
            return viewModel.configureCollectionCell(in: tableView, for: indexPath)

        case 2:
            return viewModel.configureUserCell(in: tableView, for: indexPath)
            
        default:
            fatalError("segment control error")
        }
    }
}
extension SearchViewController: UITableViewDelegate {
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchSearchPhoto(query: searchBar.text ?? "")
        viewModel.fetchSearchCollection(query: searchBar.text ?? "")
        viewModel.fetchSearchUser(query: searchBar.text ?? "")
    }
}
extension SearchViewController: SearchViewModelDelegate {
    func reload() {
        self.tableView.reloadData()
    }
    
    func show(error: AppError) {
        self.present(ReusableComponent.alertMessage(title: "Network Error", message: "Check your WIFI connection"), animated: true)
    }
}
