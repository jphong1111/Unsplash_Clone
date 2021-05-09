//
//  UploadViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import UIKit

class UploadViewController: UIViewController {

    let viewModel = UploadViewModel()
    lazy var imagePicker = ImagePicker(presentationController: self, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension UploadViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
    }
}
