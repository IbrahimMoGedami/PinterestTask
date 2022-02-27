//
//  Alert.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 27/02/2022.
//

import UIKit

class Alert {
    
    class func showAlert(title : String, message : String , handler: ((UIAlertAction) -> Void)? = nil , `on` vc : ((UIViewController))? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        vc?.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                guard vc?.presentedViewController == alert else { return }
                vc?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
