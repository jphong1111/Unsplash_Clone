//
//  LogInPopUpViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/17/21.
//

import UIKit

class LogInPopUpViewController: UIViewController {

    @IBOutlet private weak var logInViewContainer: UIView! {
        didSet {
            ReusableComponent.addRadiusForButton(self.logInViewContainer)
        }
    }
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var pressedJoin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
