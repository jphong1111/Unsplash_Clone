//
//  DetailMenuViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Firebase
import Hero
import UIKit

class DetailMenuViewModel {
    let db = Firestore.firestore()
    
    func heroTouchImage(sender: UIPanGestureRecognizer, viewController: UIViewController, image: UIImageView) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / viewController.view.bounds.height
        switch sender.state {
        case .began:
            viewController.hero_dismissViewController()
            
        case .changed:
            Hero.shared.update(progress)
            
            let currentPosition = CGPoint(x: translation.x + image.center.x, y: translation.y + image.center.y)
            Hero.shared.apply(modifiers: [.position(currentPosition)], to: image)
            
        default:
            if progress + sender.velocity(in: nil).y / viewController.view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    func downloadImage(url: String) {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        if let url = URL(string: url) {
            URLSession.shared.downloadTask(with: url) { location, response, error in
                guard let location = location else {
                    print("download error:", error ?? "")
                    return
                }
                do {
                    try FileManager.default.moveItem(at: location, to: documents.appendingPathComponent(response?.suggestedFilename ?? url.lastPathComponent))
                    print(url)
                    print(location)
                } catch {
                    print(error)
                }
            }
            .resume()
        }
    }
    func downloadImages(url: String) {
        guard let urls = URL(string: url) else { fatalError("error") }
        if let data = try? Data(contentsOf: urls),
           let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
//    @objc
//    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer, viewController: UIViewController) {
//        if let error = error {
//            // we got back an error!
//            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            viewController.present(ac, animated: true)
//        } else {
//            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            viewController.present(ac, animated: true)
//        }
//    }
    func addUrlToServer(url: String, author: String) {
        guard let uid = Auth.auth().currentUser?.uid else { fatalError("error in current user") }
        db.collection("photoUrl").addDocument(data: ["uid": uid, "url": url, "author": author]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func addCollectionToServer(url: String, author: String) {
        guard let uid = Auth.auth().currentUser?.uid else { fatalError("error in current user") }
        db.collection("collectionUrl").addDocument(data: ["uid": uid, "url": url, "author": author]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
