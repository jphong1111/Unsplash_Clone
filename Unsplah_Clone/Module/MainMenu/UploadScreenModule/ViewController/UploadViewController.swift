//
//  UploadViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
    }
    lazy var viewModel = UploadViewModel(delegate: self)
    lazy var imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPhotoDetails()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction private func contributeImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}
extension UploadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.configureCell(in: collectionView, for: indexPath)
    }
}
extension UploadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.linkedToBlog(for: indexPath)
    }
}

extension UploadViewController: UploadViewModelDelegate {
    func reload() {
        self.collectionView.reloadData()
    }
    
    func show(error: AppError) {
        self.present(ReusableComponent.alertMessage(title: "Network Error", message: "Check your WIFI connection"), animated: true)
    }
}

extension UploadViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
    }
}
