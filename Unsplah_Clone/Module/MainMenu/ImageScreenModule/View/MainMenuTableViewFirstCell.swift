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
//        let myQueue = DispatchQueue(label: "q1", attributes: .concurrent)
//        myQueue.
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = photoImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.nameLabel.text = configurator.author
        self.photoImageView.sd_setImage(with: URL(string: configurator.photoImage))
        self.photoImageView.addSubview(blurEffectView)
        self.photoImageView.heroID = configurator.photoImage
    }
}
