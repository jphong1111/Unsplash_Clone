//
//  MainMenuTableViewFirstViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

protocol MainMenuTableViewFirstViewModelProtocol {
    var photoImage: String { get }
    var photoImageSmall: String { get }
    var photoImageRegular: String { get }
    var photoImageRaw: String { get }
    var author: String { get }
    var id: String { get }
}
class MainMenuTableViewFirstViewModel: MainMenuTableViewFirstViewModelProtocol {
    
    let photos: Photos
    
    init(photos: Photos) {
        self.photos = photos
    }
    
    var photoImage: String {
        photos.urls.thumb ?? ""
    }
    
    var photoImageSmall: String {
        photos.urls.small ?? ""
    }
    var photoImageRegular: String {
        photos.urls.regular ?? ""
    }
    var photoImageRaw: String {
        photos.urls.raw ?? ""
    }
    var author: String {
        photos.user.name ?? " "
    }
    
    var id: String {
        photos.id
    }
}
