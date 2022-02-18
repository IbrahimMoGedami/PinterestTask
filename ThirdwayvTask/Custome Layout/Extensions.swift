//
//  Extensions.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import UIKit

extension UICollectionViewCell {
    func shadowDecorate(color : CGColor) {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = color
        contentView.layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
}

extension UIViewController {
    
    func showHideAlert(title : String, message : String , handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard self?.presentedViewController == alert else { return }
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

var associateObjectValue: Int = 0
extension UIImageView {
    
    fileprivate var cacheUrl: String? {
        get {
            return objc_getAssociatedObject(self, &associateObjectValue) as? String
        }
        set {
            return objc_setAssociatedObject(self, &associateObjectValue, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func loadImageWithURL(_ url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            
            if error == nil, let url = url,
               let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
}

