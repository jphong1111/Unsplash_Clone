//
//  DetailMenuViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/13/21.
//

import Hero
import SDWebImage
import UIKit

class DetailMenuViewController: UIViewController {
    @IBOutlet private weak var detailImage: UIImageView! {
        didSet {
            self.detailImage.sd_setImage(with: URL(string: dataSource?.photoImage ?? ""))
            self.detailImage.heroID = dataSource?.photoImage
        }
    }
    
    @IBOutlet private weak var heartButton: UIButton!
    var dataSource: MainMenuTableViewFirstViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = dataSource?.author
    }
    @IBAction private func dismissButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func isHeartClicked(_ sender: UIButton) {
        if UIImage(named: "heart") != nil {
            sender.setImage(UIImage(named: "heart.png"), for: .normal)
        }
        if UIImage(named: "heartFill") != nil {
            sender.setImage(UIImage(named: "heartFill.png"), for: .selected)
        }
    }
    @IBAction private func shareLink(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: ["https://unsplash.com"], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction private func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        switch sender.state {
        case .began:
            hero_dismissViewController()
            
        case .changed:
            Hero.shared.update(progress)
            
            let currentPosition = CGPoint(x: translation.x + detailImage.center.x, y: translation.y + detailImage.center.y)
            Hero.shared.apply(modifiers: [.position(currentPosition)], to: detailImage)
            
        default:
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}
