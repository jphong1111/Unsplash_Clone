//
//  NetworkRouter.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import Foundation

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request<T: Decodable>(_ route: EndPoint, completion: @escaping NetworkRouterCompletion<T>)
    func cancel()
}
