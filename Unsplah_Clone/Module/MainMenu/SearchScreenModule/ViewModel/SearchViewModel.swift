//
//  SearchViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func reload()
    func show(error: AppError)
}
class SearchViewModel {
    private let router = Router<PhotoAPI>()
    
    private var photoDataSource = [PhotoResult]() {
        didSet {
            self.delegate?.reload()
        }
    }
    private var collectionDataSource = [CollectionResult]() {
        didSet {
            self.delegate?.reload()
        }
    }
    private var userDataSource = [UserResult]() {
        didSet {
            self.delegate?.reload()
        }
    }
    weak var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchSearchPhoto(query: String) {
        self.router.request(PhotoAPI.searchPhoto(query: query, page: "1")) { [weak self] (result: Result<SearchPhoto, AppError>) in
            switch result {
            case .success(let photos):
                self?.photoDataSource = photos.results
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func fetchSearchCollection(query: String) {
        self.router.request(PhotoAPI.searchCollection(query: query, page: "1")) { [weak self] (result: Result<SearchCollection, AppError>) in
            switch result {
            case .success(let photos):
                self?.collectionDataSource = photos.results
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func fetchSearchUser(query: String) {
        self.router.request(PhotoAPI.searchUser(query: query, page: "1")) { [weak self] (result: Result<SearchUser, AppError>) in
            switch result {
            case .success(let photos):
                self?.userDataSource = photos.results
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func numberOfPhotos() -> Int {
        self.photoDataSource.count
    }
    func numberOfCollections() -> Int {
        self.collectionDataSource.count
    }
    func numberOfUsers() -> Int {
        self.userDataSource.count
    }
    func searchedPhoto(at index: Int) -> SearchTableViewCellViewModelProtocol {
        SearchTableViewCellViewModel(searchPhoto: self.photoDataSource[index])
    }
    func searchedPhotoCollection(at index: Int) -> SearchCollectionTableViewCellViewModelProtocol {
        SearchCollectionTableViewCellViewModel(searchPhotoCollection: self.collectionDataSource[index])
    }
    func searchedUser(at index: Int) -> SearchUserTableViewCellViewModelProtocol {
        SearchUserTableViewCellViewModel(searchUser: self.userDataSource[index])
    }
    func configurePhotoCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
        else { fatalError("not find") }
        let searchedPhoto = self.searchedPhoto(at: indexPath.row)
        cell.configure(configurator: searchedPhoto)
        return cell
    }
    func configureCollectionCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: SearchCollectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchCollectionTableViewCell") as? SearchCollectionTableViewCell
        else { fatalError("not find") }
        let searchedCollectionPhoto = self.searchedPhotoCollection(at: indexPath.row)
        cell.configure(configurator: searchedCollectionPhoto)
        return cell
    }
    func configureUserCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: SearchUserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchUserTableViewCell") as? SearchUserTableViewCell
        else { fatalError("not find") }
        let searchedUserInfo = self.searchedUser(at: indexPath.row)
        cell.configure(configurator: searchedUserInfo)
        return cell
    }
}
