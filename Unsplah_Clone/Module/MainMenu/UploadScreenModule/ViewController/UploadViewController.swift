//
//  UploadViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/9/21.
//

import UIKit

class UploadViewController: UIViewController {

    let viewModel = UploadViewModel()
    
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
}
