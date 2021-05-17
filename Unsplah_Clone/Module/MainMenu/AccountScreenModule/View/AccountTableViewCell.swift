//
//  AccountTableViewCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/17/21.
//

import SDWebImage
import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var photoImage: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    
    func configure(author: String, photoImage: String) {
        self.photoImage.sd_setImage(with: URL(string: photoImage))
        self.authorLabel.text = author
    }
}
