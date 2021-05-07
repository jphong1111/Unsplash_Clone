//
//  ReusableComponent.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Foundation

enum ReusableComponent {
}

protocol CellReusable {
    static var cellIdentifier: String { get }
}

extension CellReusable {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
