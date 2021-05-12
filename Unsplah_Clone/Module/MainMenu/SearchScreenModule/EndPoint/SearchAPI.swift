//
//  SearchAPI.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

enum SearchAPI: EndPointType {
    case search(query: String)

    var path: String {
        switch self {
        case .search(let query):
            return "&query=" + "\(query)"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?page=1&client_id=2TZgdxa0VJ5bOq4Kbdd0ITUxRUgNN7Fk5kVm87EsloU") else {
            fatalError("Bad Base Url")
        }
        return url
    }
    var task: HTTPTask {
        .request
    }
}
