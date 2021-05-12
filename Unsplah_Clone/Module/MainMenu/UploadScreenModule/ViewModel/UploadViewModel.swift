//
//  UploadViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import UIKit

protocol UploadViewModelDelegate: AnyObject {
    func reload()
    func show(error: AppError)
}

class UploadViewModel {
    
    private let router = Router<PhotoAPI>()
    
    private var dataSource = [LatestCollectionCellViewModelProtocol]() {
        didSet {
            self.delegate?.reload()
        }
    }
    weak var delegate: UploadViewModelDelegate?
    
    init(delegate: UploadViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPhotoDetails() {
        self.router.request(PhotoAPI.photo) { [weak self] (result: Result<[LatestPhoto], AppError>) in
            switch result {
            case .success(let photos):
                self?.dataSource = photos.compactMap { LatestCollectionCellViewModel(latestPhoto: $0) }
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
    func numberOfRows() -> Int {
        self.dataSource.count
    }
    func latestPhoto(at index: Int) -> LatestCollectionCellViewModelProtocol {
        self.dataSource[index]
    }
    func configureCell(in collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LatestCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCollectionViewCell", for: indexPath) as? LatestCollectionViewCell
        else { fatalError("not find") }
        let photo = self.latestPhoto(at: indexPath.row)
        cell.configure(configurator: photo)
        return cell
    }
    func linkedToBlog(for indexPath: IndexPath) {
        let blogLink = self.latestPhoto(at: indexPath.row).htmlLink
        ReusableComponent.linkToUrl(url: blogLink)
    }
}
