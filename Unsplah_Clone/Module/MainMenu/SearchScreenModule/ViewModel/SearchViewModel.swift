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
    
    private var dataSource = [PhotoResult]() {
        didSet {
            self.delegate?.reload()
        }
    }
    weak var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPhotoDetails(query: String) {
        self.router.request(PhotoAPI.searchPhoto(query: query, page: "1")) { [weak self] (result: Result<SearchPhoto, AppError>) in
            switch result {
            case .success(let photos):
                self?.dataSource = photos.results
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func numberOfRows() -> Int {
        self.dataSource.count
    }
    func searchedPhoto(at index: Int) -> SearchTableViewCellViewModelProtocol {
        SearchTableViewCellViewModel(searchPhoto: self.dataSource[index])
    }
    func configureCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
        else { fatalError("not find") }
        let searchedPhoto = self.searchedPhoto(at: indexPath.row)
        cell.configure(configurator: searchedPhoto)
        return cell
    }
}
