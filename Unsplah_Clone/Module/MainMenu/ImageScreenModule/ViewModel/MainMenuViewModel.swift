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
    
    var collectionDataSource: [String] = ["Editorial", "Wallpapers", "Nature", "People", "Architecture", "Current Events", "Experimental", "Fashion", "Film", "Interiors"]
    
    init(delegate: MainMenuViewModelDelegate) {
        self.delegate = delegate
    }
    func fetchPhoto() {
        self.router.request(PhotoAPI.photoWithPage(page: "1")) { [weak self] (result: Result<[Photos], AppError>) in
            switch result {
            case .success(let photos):
                self?.dataSource = photos.compactMap { MainMenuTableViewFirstViewModel(photos: $0) }
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func fetchPhotoByCollection(topics: String) {
        if topics != "editorial" {
            self.router.request(PhotoAPI.topicsSearch(topic: topics, page: "1")) { [weak self] (result: Result<[Photos], AppError>)  in
                switch result {
                case .success(let photos):
                    self?.dataSource = photos.compactMap { MainMenuTableViewFirstViewModel(photos: $0) }
                
                case .failure(let error):
                    self?.delegate?.show(error: error)
                }
            }
        } else {
            fetchPhoto()
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
    func topicFind(for indexPath: IndexPath) -> String {
        collectionDataSource[indexPath.row].lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    }
    // MARK: - tableview configure functions
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
    func addHeaderView(in tableView: UITableView, view: UIView) {
        let label = UILabel()
        label.text = "Photos for everyone"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        headerView.imageView?.image = UIImage(named: "startImage")
        headerView.addSubview(label)
        let xConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1, constant: 0)

        let yConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([yConstraint, xConstraint])
        tableView.tableHeaderView = headerView
    }
}
