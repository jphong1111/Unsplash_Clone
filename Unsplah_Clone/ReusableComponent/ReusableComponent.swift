//
//  ReusableComponent.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

enum ReusableComponent {
    
    static func addRadiusForButton(_ view: UIView) {
        // view.layer.shadowOpacity = 0.5
        // view.layer.shadowOffset = CGSize(width: 0, height: 3)
        //  view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
    }
}

protocol CellReusable {
    static var cellIdentifier: String { get }
}

extension CellReusable {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
