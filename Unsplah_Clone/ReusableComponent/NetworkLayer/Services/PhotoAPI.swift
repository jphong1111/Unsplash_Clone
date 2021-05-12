//
//  PhotoAPI.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

enum PhotoAPI {
    case collections
    case photo
    case searchPhoto(query: String, page: String)
}

extension PhotoAPI: EndPointType {
    var path: String {
        switch self {
        case .collections:
            return "collections/"
        case .photo:
            return "photos/"
        case .searchPhoto(let query, let page):
            return "search/photos"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .collections:
            return .requestParameters((bodyParameters: nil,
                                       urlParameters: ["client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .photo:
            return .requestParameters((bodyParameters: nil, urlParameters: ["client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .searchPhoto(let query, let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "query": query, "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
        }
    }
}
