//
//  MainCollectionViewCell.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/13/21.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var title: UILabel!
    
    func configure(title: String) {
        self.title.text = title
    }
}
