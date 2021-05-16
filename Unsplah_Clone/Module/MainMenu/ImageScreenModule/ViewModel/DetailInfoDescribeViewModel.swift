//
//  DetailInfoDescribeViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Foundation

protocol DetailInfoDescribeViewModelProtocol {
    var id: String { get }
    var width: Int { get }
    var height: Int { get }
    var createdTime: String { get }
    var make: String? { get }
    var model: String? { get }
    var exposureTime: String? { get }
    var aperture: String? { get }
    var focalLength: String? { get }
    var iso: Int? { get }
}
class DetailInfoDescribeViewModel: DetailInfoDescribeViewModelProtocol {

    let photoInfo: PhotoInfo
    
    init(photoInfo: PhotoInfo) {
        self.photoInfo = photoInfo
    }
    
    var id: String {
        photoInfo.id
    }
    
    var width: Int {
        photoInfo.width
    }
    
    var height: Int {
        photoInfo.height
    }
    
    var createdTime: String {
        photoInfo.createdTime
    }
    
    var make: String? {
        photoInfo.exif.make
    }
    
    var model: String? {
        photoInfo.exif.model
    }
    
    var exposureTime: String? {
        photoInfo.exif.exposureTime
    }
    
    var aperture: String? {
        photoInfo.exif.aperture
    }
    
    var focalLength: String? {
        photoInfo.exif.focalLength
    }
    
    var iso: Int? {
        photoInfo.exif.iso
    }
}
