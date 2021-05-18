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
    static func addRadiusForImage(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    static func addCircleShapeForImage(_ view: UIView) {
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = view.frame.size.width / 2
        view.clipsToBounds = true
    }
    static func alertMessage(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        return alert
    }
    static func linkToUrl(url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
