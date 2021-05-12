//
//  SearchTableViewCellViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import UIKit

protocol SearchTableViewCellViewModelProtocol {
    var image: String { get }
}

class SearchTableViewCellViewModel: SearchTableViewCellViewModelProtocol {

    let searchPhoto: PhotoResult

    init(searchPhoto: PhotoResult) {
        self.searchPhoto = searchPhoto
    }
    
    var image: String {
        searchPhoto.urls?.small ?? ""
    }
}
