//
//  SubMenuViewController.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/10/21.
//

import Firebase
import MessageUI
import UIKit

class SubMenuViewController: UIViewController {
    
    @IBOutlet private weak var doneButton: UIBarButtonItem!
    @IBOutlet private weak var recommendButton: UIButton!
    @IBOutlet private weak var reviewButton: UIButton!
    @IBOutlet private weak var feedbackButton: UIButton!
    @IBOutlet private weak var visitButton: UIButton!
    @IBOutlet private weak var licenseButton: UIButton!
    @IBOutlet private weak var signOutButton: UIButton! {
        didSet {
            if Auth.auth().currentUser != nil {
                self.signOutButton.isHidden = false
            } else {
                self.signOutButton.isHidden = true
            }
        }
    }
    
    lazy var conversation = ConversationManager(presentingController: self, mailDelegate: self, viewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func clickDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func visitWebsite(_ sender: UIButton) {
        ReusableComponent.linkToUrl(url: "https://unsplash.com")
    }
    
    @IBAction private func sendFeedback(_ sender: UIButton) {
        conversation.sendEmail(feedback: MailFeedback(recipients: ["jzh0169@auburn.edu"], subject: "Feedback", body: "Write here"))
    }
    @IBAction private func writeReview(_ sender: UIButton) {
        ReusableComponent.linkToUrl(url: "https://apps.apple.com/us/app/unsplash/id1290631746#see-all/reviews")
    }
    @IBAction private func seeLicense(_ sender: UIButton) {
        ReusableComponent.linkToUrl(url: "https://unsplash.com/license")
    }
    @IBAction private func signOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("already logged out")
        }
    }
}
extension SubMenuViewController: MFMailComposeViewControllerDelegate {
}
