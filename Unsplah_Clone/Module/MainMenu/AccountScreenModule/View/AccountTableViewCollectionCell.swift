//
//  AccountTableViewCollectionCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/18/21.
//

import SDWebImage
import UIKit

class AccountTableViewCollectionCell: UITableViewCell {
    @IBOutlet private weak var photoImage: UIImageView! {
        didSet {
            ReusableComponent.addRadiusForImage(self.photoImage)
        }
    }
    @IBOutlet private weak var author: UILabel!
    
    func configure(photoImage: String, author: String) {
        self.photoImage.sd_setImage(with: URL(string: photoImage))
        self.author.text = author
    }
}
