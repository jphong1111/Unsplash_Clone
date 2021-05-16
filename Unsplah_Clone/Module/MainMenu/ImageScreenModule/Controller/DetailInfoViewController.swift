//
//  DetailInfoViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import UIKit

class DetailInfoViewController: UIViewController {
    @IBOutlet private weak var makeLabel: UILabel! {
        didSet {
            self.makeLabel.text = dataSource?.make ?? ""
        }
    }
    @IBOutlet private weak var modelLabel: UILabel! {
        didSet {
            self.modelLabel.text = dataSource?.model ?? ""
        }
    }
    @IBOutlet private weak var shutterSpeedLabel: UILabel! {
        didSet {
            self.shutterSpeedLabel.text = "\(String(describing: dataSource?.exposureTime ?? ""))s"
        }
    }
    @IBOutlet private weak var apertureLabel: UILabel! {
        didSet {
            self.apertureLabel.text = dataSource?.aperture ?? ""
        }
    }
    @IBOutlet private weak var focalLengthLabel: UILabel! {
        didSet {
            self.focalLengthLabel.text = dataSource?.focalLength ?? ""
        }
    }
    @IBOutlet private weak var isoLabel: UILabel! {
        didSet {
            self.isoLabel.text = String(dataSource?.iso ?? 0)
        }
    }
    @IBOutlet private weak var dimensionsLabel: UILabel! {
        didSet {
            self.dimensionsLabel.text = "\(String(describing: dataSource?.width)) x \(String(describing: dataSource?.height))"
        }
    }
    @IBOutlet private weak var publishedLabel: UILabel! {
        didSet {
            self.publishedLabel.text = detailInfoViewModel.dataSource?.createdTime
        }
    }
    
    @IBAction private func dismissCurrentView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var id: String?
    var dataSource: DetailInfoDescribeViewModelProtocol?
    lazy var detailInfoViewModel = DetailInfoViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailInfoViewModel.fetchPhotoInfo(id: id ?? "")
    }
}
extension DetailInfoViewController: DetailInfoViewModelDelegate {
    func reload() {
    }
    
    func show(error: AppError) {
        print(error)
    }
}
