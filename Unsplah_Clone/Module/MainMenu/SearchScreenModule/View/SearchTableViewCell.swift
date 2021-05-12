//
//  SearchTableViewCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/11/21.
//

import SDWebImage
import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet private weak var searchImage: UIImageView!
    
    func configure(configurator: SearchTableViewCellViewModelProtocol) {
        self.searchImage.sd_setImage(with: URL(string: configurator.image))
    }
}
