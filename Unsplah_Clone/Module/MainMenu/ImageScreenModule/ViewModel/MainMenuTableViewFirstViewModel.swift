//
//  MainMenuTableViewFirstViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

protocol MainMenuTableViewFirstViewModelProtocol {
    var photoImage: String { get }
    var author: String { get }
    var id: String { get }
}
class MainMenuTableViewFirstViewModel: MainMenuTableViewFirstViewModelProtocol {
    
    let photos: Photos
    
    init(photos: Photos) {
        self.photos = photos
    }
    
    var photoImage: String {
        photos.urls.small ?? ""
    }
    
    var author: String {
        photos.user.name ?? " "
    }
    
    var id: String {
        photos.id
    }
}
