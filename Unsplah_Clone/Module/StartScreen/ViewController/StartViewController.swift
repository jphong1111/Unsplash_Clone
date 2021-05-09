//
//  StartViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/5/21.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveImage(imageView, 10)
    }
    
    @IBAction private func showMainMenu(_ sender: UIButton) {
    }

    func moveImage(_ imageView: UIView, _ speed: CGFloat) {
        let speeds = speed
        let imageSpeed = speeds / view.frame.size.width
        let averageSpeed = (view.frame.size.width - imageView.frame.origin.x) * imageSpeed
        UIView.animate(withDuration: TimeInterval(averageSpeed),
                       delay: 0.0,
                       options: .curveLinear) {
            imageView.frame.origin.x = self.view.frame.size.width
        } completion: { _ in
            imageView.frame.origin.x = -imageView.frame.size.width
            self.moveImage(imageView, speeds)
        }
    }
}
