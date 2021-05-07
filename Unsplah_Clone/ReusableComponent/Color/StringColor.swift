//
//  StringColor.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

enum StringColor {
    static func changeColor(textField: UITextField, text: String, color: UIColor) {
        textField.attributedPlaceholder = NSAttributedString(string: text,
                                                             attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
