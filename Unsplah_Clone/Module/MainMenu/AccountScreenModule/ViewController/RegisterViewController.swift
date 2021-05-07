//
//  RegisterViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/7/21.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Login"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
    }
}
