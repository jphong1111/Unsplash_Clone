//
//  Photos.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/13/21.
//

import Foundation

struct Photos: Decodable {
    let id: String
    let urls: Urls
    let user: User
}
