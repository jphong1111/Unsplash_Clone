//
//  PhotoAPI.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

// enum PhotoAPI {
//    case photos
//    case collections
// }

enum PhotoAPI: EndPoint {
    case photo
    
    var path: String {
        switch self {
        case .photo:
            return ""
        }
    }
    var baseURL: URL {
        guard let url = URL(string: "https://api.unsplash.com/photos/?client_id=2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU") else {
            fatalError("Bad Base Url")
        }
        return url
    }
    var task: HTTPTask {
        .request
    }
}
