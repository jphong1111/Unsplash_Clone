//
//  DetailMenuViewModel.swift
//  Unsplah_Clone
//
//  Created by JungpyoHong on 5/14/21.
//

import Hero
import UIKit

class DetailMenuViewModel {
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
//    func load(URL: NSURL) {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        let request = NSMutableURLRequest(url: URL as URL)
//        request.httpMethod = "GET"
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { _, response, error in
//            if error == nil {
//                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { fatalError("no status code") }
//                print("Success: \(statusCode)")
//            } else {
//                print("Failure")
//            }
//        })
//        task.resume()
//    }
    func addUrlToServer() {
    }
}
