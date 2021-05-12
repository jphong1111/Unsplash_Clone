//
//  SearchCollection.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/12/21.
//

import Foundation

struct SearchCollection: Decodable {
    let results: [CollectionResult]
}
struct CollectionResult: Decodable {
    let coverPhoto: SearchURL
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo"
        case title
    }
}
struct SearchURL: Decodable {
    let urls: Size
}
struct Size: Decodable {
    let small: String
}
