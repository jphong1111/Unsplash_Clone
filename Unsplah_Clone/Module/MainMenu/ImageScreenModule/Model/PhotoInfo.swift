//
//  PhotoInfo.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Foundation

struct PhotoInfo: Decodable {
    let id: String
    let width: Int
    let height: Int
    let createdTime: String
    let exif: Exif
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, exif
        case createdTime = "created_at"
    }
}
struct Exif: Decodable {
    let make: String?
    let model: String?
    let exposureTime: String?
    let aperture: String?
    let focalLength: String?
    let iso: Int?
    
    enum CodingKeys: String, CodingKey {
        case make, model, aperture, iso
        case exposureTime = "exposure_time"
        case focalLength = "focal_length"
    }
}
