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
        case "themeBlack":
            return UIColor(cgColor: CGColor(red: 17 / 255, green: 17 / 255, blue: 17 / 255, alpha: 255 / 255))
            
        case "lightBlack":
            return UIColor(cgColor: CGColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 255 / 255))
            
        default:
            return .clear
        }
    }
}
