//
//  LatestPhoto.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/10/21.
//

import Foundation

struct LatestPhoto: Decodable {
    let description: String?
    let urls: Urls
    let links: Link
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case description = "alt_description"
        case urls, links, user
    }
}

struct User: Decodable {
    let name: String?
}
struct Urls: Decodable {
    let regular: String?
    let thumb: String?
}

struct Link: Decodable {
    let html: String
}
