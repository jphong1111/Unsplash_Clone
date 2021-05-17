//
//  Color.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

enum Color: String {
    case realBlack
    case lightGray
    case heavyGray
    
    var color: UIColor {
        switch self.rawValue {
        case "themeBlack":
            return UIColor(cgColor: CGColor(red: 17 / 255, green: 17 / 255, blue: 17 / 255, alpha: 255 / 255))
            
        case "lightBlack":
            return UIColor(cgColor: CGColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 255 / 255))
        
        case "lightGray":
            return UIColor(cgColor: CGColor(red: 100 / 255, green: 99 / 255, blue: 105 / 255, alpha: 255 / 255))
            
        case "heavyGray":
            return UIColor(cgColor: CGColor(red: 41 / 255, green: 40 / 255, blue: 45 / 255, alpha: 255 / 255))
            
        default:
            return .clear
        }
    }
}
