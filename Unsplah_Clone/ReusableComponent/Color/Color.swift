//
//  Color.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

enum Color: String {
    case realBlack
    
    var color: UIColor {
        switch self.rawValue {
        case "realBlack":
            return UIColor(cgColor: CGColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 255 / 255))
            
        default:
            return .clear
        }
    }
}
