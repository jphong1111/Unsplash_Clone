//
//  AccountTableViewCellViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/17/21.
//

import Foundation

protocol AccountTableViewCellViewModelProtocol {
    var photoImage: String { get }
    var author: String { get }
}
class AccountTableViewCellViewModel: AccountTableViewCellViewModelProtocol {
    
    let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    var photoImage: String {
        userData.url
    }
    
    var author: String {
        userData.author
    }
}
