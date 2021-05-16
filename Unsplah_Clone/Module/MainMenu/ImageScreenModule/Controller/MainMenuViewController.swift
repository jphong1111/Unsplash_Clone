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
            self.tableView.reloadData()
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
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
        getHeader()
        viewModel.fetchPhoto()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? DetailMenuViewController {
            destinationViewController.dataSource = viewModel.searchedPhoto(at: selectedCell)
        }
    }
    func getHeader() {
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        headerView.imageView?.image = UIImage(named: "startImage")
        self.tableView.tableHeaderView = headerView
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
extension MainMenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let headerView = self.tableView.tableHeaderView as? StretchyTableHeaderView else { fatalError("no header find") }
        headerView.scrollViewDidScroll(scrollView: scrollView)
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
extension MainMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = viewModel.topicFind(for: indexPath)
        viewModel.fetchPhotoByCollection(topics: topic)
    }
}
extension MainMenuViewController: MainMenuViewModelDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func show(error: AppError) {
        self.present(ReusableComponent.alertMessage(title: "Network Error", message: "Check your WIFI connection"), animated: true)
    }
}
