//
//  SearchCollectionTableViewCellViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/12/21.
//

import Foundation

protocol SearchCollectionTableViewCellViewModelProtocol {
    var image: String { get }
    var title: String { get }
}
class SearchCollectionTableViewCellViewModel: SearchCollectionTableViewCellViewModelProtocol {
    let searchPhotoCollection: CollectionResult

    init(searchPhotoCollection: CollectionResult) {
        self.searchPhotoCollection = searchPhotoCollection
    }
    
    var image: String {
        searchPhotoCollection.coverPhoto.urls.small
    }
    
    var title: String {
        searchPhotoCollection.title
    }
}
