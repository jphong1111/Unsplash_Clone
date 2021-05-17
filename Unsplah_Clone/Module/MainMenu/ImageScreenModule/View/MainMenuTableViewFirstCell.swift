//
//  MainMenuTableViewFirstCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import Hero
import SDWebImage
import UIKit

class MainMenuTableViewFirstCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!

    func configure(configurator: MainMenuTableViewFirstViewModelProtocol) {
        self.nameLabel.text = configurator.author
        let blur = SDImageBlurTransformer(radius: 5.6)
        SDWebImageManager.shared.loadImage(
            with: URL(string: configurator.photoImageRegular),
            options: [.fromLoaderOnly],
            context: [.storeCacheType: SDImageCacheType.none.rawValue, .imageTransformer: blur],
            progress: nil,
            completed: { _, _, _, _, _, _ in
                // the `image` is resized
            })
        self.photoImageView.sd_setImage(with: URL(string: configurator.photoImageRegular))
        self.photoImageView.heroID = configurator.photoImageRegular
    }
    
    private func getThumbImage(configurator: String, leaveGroup: DispatchGroup) {
            DispatchQueue.main.async {
                self.photoImageView.sd_setImage(with: URL(string: configurator)) { _, _, _, _ in
                    leaveGroup.leave()
                    self.detachBlurry(for: self.photoImageView ?? UIImageView())
                    print("detach blurry1")
                }
            }
        }
    private func getRawImage(configurator: String, leaveGroup: DispatchGroup) {
            DispatchQueue.main.async {
                self.photoImageView.sd_setImage(with: URL(string: configurator)) { _, _, _, _ in
                    self.attachBlurry(for: self.photoImageView)
                    print("attach")
                    leaveGroup.leave()
                }
            }
        }
    func attachBlurry(for view: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = photoImageView.bounds
        blurEffectView.tag = 9
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    func detachBlurry(for view: UIView) {
        view.viewWithTag(9)?.removeFromSuperview()
    }
}
