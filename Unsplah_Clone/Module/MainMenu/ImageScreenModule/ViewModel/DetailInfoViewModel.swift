//
//  DetailInfoViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Foundation

protocol DetailInfoViewModelDelegate: AnyObject {
    func reload()
    func show(error: AppError)
}
class DetailInfoViewModel {
    
    private let router = Router<PhotoAPI>()
    
    var dataSource: DetailInfoDescribeViewModelProtocol? {
        didSet {
            self.delegate?.reload()
        }
    }
    weak var delegate: DetailInfoViewModelDelegate?
    
    init(delegate: DetailInfoViewModelDelegate) {
        self.delegate = delegate
    }
    func fetchPhotoInfo(id: String) {
        print("++++++\(id)+++++")
        var idd = id
        idd = "CTflmHHVrBM"
        self.router.request(PhotoAPI.photoID(id: idd)) { [weak self] (result: Result<PhotoInfo, AppError>) in
            switch result {
            case .success(let photos):
                self?.dataSource = DetailInfoDescribeViewModel(photoInfo: photos)
                
            case .failure(let error):
                self?.delegate?.show(error: error)
            }
        }
    }
}
