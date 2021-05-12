//
//  SearchPhoto.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

struct SearchPhoto: Decodable {
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let urls: ResultUrl?
}

struct ResultUrl: Decodable {
    let small: String
}
