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
        }
    }
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
    
    @IBAction private func didChangeSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            viewModel.fetchPhotoDetails(query: searchBar.text ?? "")
        } else if sender.selectedSegmentIndex == 1 {
        } else {
        }
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(in: tableView, for: indexPath)
    }
}
extension SearchViewController: UITableViewDelegate {
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchPhotoDetails(query: searchBar.text ?? "")
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
