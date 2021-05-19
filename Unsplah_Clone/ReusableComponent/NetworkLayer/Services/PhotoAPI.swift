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
    case photoWithPage(page: String)
    case photoID(id: String)
    case topics(page: String)
    case topicsSearch(topic: String, page: String)
    case searchPhoto(query: String, page: String)
    case searchCollection(query: String, page: String)
    case searchUser(query: String, page: String)
}

extension PhotoAPI: EndPointType {
    var path: String {
        switch self {
        case .collections:
            return "collections/"
        case .photo:
            return "photos/"
        case .photoWithPage:
            return "photos/"
        case .photoID(let id):
            return "photos/\(id)/"
        case .topics:
            return "topics/"
        case .topicsSearch(let topic, _):
            return "topics/\(topic)/photos/"
        case .searchPhoto:
            return "search/photos"
        case .searchCollection:
            return "search/collections"
        case .searchUser:
            return "search/users"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .collections:
            return .requestParameters((bodyParameters: nil,
                                       urlParameters: ["client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .photo:
            return .requestParameters((bodyParameters: nil, urlParameters: ["per_page": "20", "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .photoWithPage(let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .photoID:
            return .requestParameters((bodyParameters: nil, urlParameters: ["client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .topics(let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .topicsSearch(_, let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .searchPhoto(let query, let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "query": query, "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .searchCollection(let query, let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "query": query, "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
            
        case .searchUser(let query, let page):
            return .requestParameters((bodyParameters: nil, urlParameters: ["page": page, "per_page": "40", "query": query, "client_id": "2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU"]))
        }
    }
}
