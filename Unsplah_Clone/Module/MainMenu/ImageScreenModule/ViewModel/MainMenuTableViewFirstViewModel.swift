//
//  MainMenuTableViewFirstViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

protocol MainMenuTableViewFirstViewModelProtocol {
    var photoImage: UIImage { get }
    var photoSponsor: String { get }
    var author: String { get }
}
class MainMenuTableViewFirstViewModel: MainMenuTableViewFirstViewModelProtocol {
    
    var photoImage: UIImage {
        UIImage()
    }
    
    var photoSponsor: String {
        ""
    }
    
    var author: String {
        ""
    }
}
