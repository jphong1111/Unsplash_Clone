//
//  NetworkResponse.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

enum NetworkResponse: String {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
