//
//  DetailMenuViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Hero
import UIKit

class DetailMenuViewModel {
    func heroTouchImage(sender: UIPanGestureRecognizer, viewController: UIViewController, image: UIImageView) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / viewController.view.bounds.height
        switch sender.state {
        case .began:
            viewController.hero_dismissViewController()
            
        case .changed:
            Hero.shared.update(progress)
            
            let currentPosition = CGPoint(x: translation.x + image.center.x, y: translation.y + image.center.y)
            Hero.shared.apply(modifiers: [.position(currentPosition)], to: image)
            
        default:
            if progress + sender.velocity(in: nil).y / viewController.view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}
