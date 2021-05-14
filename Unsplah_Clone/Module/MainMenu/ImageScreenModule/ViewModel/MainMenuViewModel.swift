//
//  MainMenuViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

protocol MainMenuViewModelDelegate: AnyObject {
    func reload()
    func show(error: AppError)
}
class MainMenuViewModel {
    
    private let router = Router<PhotoAPI>()
    
    private var dataSource = [MainMenuTableViewFirstViewModelProtocol]() {
        didSet {
            self.delegate?.reload()
        }
    }
    weak var delegate: MainMenuViewModelDelegate?
    
    var collectionDataSource: [String] = ["Editorial", "Wallpapers", "Nature", "People", "Architecture", "Current Events", "Business & work"]
    
    init(delegate: MainMenuViewModelDelegate) {
        self.delegate = delegate
    }
    func fetchPhoto() {
        self.router.request(PhotoAPI.photo) { [weak self] (result: Result<[Photos], AppError>) in
            switch result {
            case .success(let photos):
                self?.dataSource = photos.compactMap { MainMenuTableViewFirstViewModel(photos: $0) }
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    // MARK: - CollectionView configure functions
    func numbersOfCollection() -> Int {
        collectionDataSource.count
    }
    func collectionSelect(at index: Int) -> String {
        collectionDataSource[index]
    }
    func configureCollectionCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell
            else { fatalError("cannot find cell") }
        cell.configure(title: collectionSelect(at: indexPath.row))
        return cell
    }
    // MARK: - photo configure functions
    func numberOfPhotos() -> Int {
        self.dataSource.count
    }
    func searchedPhoto(at index: Int) -> MainMenuTableViewFirstViewModelProtocol {
        self.dataSource[index]
    }
    func configurePhotoCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: MainMenuTableViewFirstCell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewFirstCell") as? MainMenuTableViewFirstCell
        else { fatalError("not find") }
        let searchedPhoto = self.searchedPhoto(at: indexPath.row)
        cell.configure(configurator: searchedPhoto)
        return cell
    }
    func passDataToDetail(in tableView: UITableView, for indexPath: IndexPath) {
        let photoData = searchedPhoto(at: indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailMenuViewController") as? DetailMenuViewController else { fatalError("error occur") }
        detailViewController.dataSource = photoData
    }
}
