//
//  SearchCollectionTableViewCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/12/21.
//

import SDWebImage
import UIKit

class SearchCollectionTableViewCell: UITableViewCell {
    @IBOutlet private weak var collectionImageView: UIImageView! {
        didSet {
            ReusableComponent.addRadiusForImage(self.collectionImageView)
        }
    }
    @IBOutlet private weak var title: UILabel!
    
    func configure(configurator: SearchCollectionTableViewCellViewModelProtocol) {
        self.collectionImageView.sd_setImage(with: URL(string: configurator.image))
        self.title.text = configurator.title
    }
}
