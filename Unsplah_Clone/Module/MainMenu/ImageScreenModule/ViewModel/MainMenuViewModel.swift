//
//  MainMenuViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Foundation

class MainMenuViewModel {
    
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
}
