//
//  StretchyTableHeaderView.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/16/21.
//

import UIKit

class StretchyTableHeaderView: UIView {
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()
    
    var containerView: UIView?
    var imageView: UIImageView?

    var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        setViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createViews() {
        containerView = UIView()
        self.addSubview(containerView ?? UIView())
        imageView = UIImageView()
        imageView?.clipsToBounds = true
        imageView?.backgroundColor = .yellow
        imageView?.contentMode = .scaleAspectFill
        containerView?.addSubview(imageView ?? UIView())
    }
    
    func setViewConstraints() {
        guard let containerView = containerView else { fatalError("no picture") }
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalTo: imageView?.widthAnchor ?? NSLayoutDimension()).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView?.bottomAnchor.constraint(equalTo: containerView.bottomAnchor) ?? NSLayoutConstraint()
        imageViewBottom.isActive = true
        imageViewHeight = imageView?.heightAnchor.constraint(equalTo: containerView.heightAnchor) ?? NSLayoutConstraint()
        imageViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView?.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
