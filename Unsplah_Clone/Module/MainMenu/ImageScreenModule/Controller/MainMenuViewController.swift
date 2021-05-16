//
//  MainMenuViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Hero
import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.register(UINib(nibName: "MainMenuTableViewFirstCell", bundle: nil), forCellReuseIdentifier: "MainMenuTableViewFirstCell")
            //            self.tableview.register(UINib(nibName: MainMenuTableViewSecondCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: MainMenuTableViewSecondCell.cellIdentifier)
            self.tableView.reloadData()
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.backgroundColor = .clear
        }
    }
    lazy var viewModel = MainMenuViewModel(delegate: self)
    var dataSource: MainMenuTableViewFirstViewModelProtocol?
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        viewModel.fetchPhoto()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailMenuViewController {
            destinationViewController.dataSource = viewModel.searchedPhoto(at: selectedCell)
        }
    }
}
extension MainMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfPhotos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configurePhotoCell(in: tableView, for: indexPath)
    }
}
extension MainMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCell = indexPath.row
        viewModel.passDataToDetail(in: tableView, for: indexPath)
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numbersOfCollection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.configureCollectionCell(in: collectionView, for: indexPath)
    }
}
extension MainMenuViewController: MainMenuViewModelDelegate {
    func reload() {
        self.tableView.reloadData()
    }
    
    func show(error: AppError) {
        self.present(ReusableComponent.alertMessage(title: "Network Error", message: "Check your WIFI connection"), animated: true)
    }
}
