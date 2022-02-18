//
//  AppDelegate.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let window = window {
            let rootvc = storyboard.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
            let nav = UINavigationController(rootViewController: rootvc)
            window.rootViewController = nav
            window.makeKeyAndVisible()
            
        }
        
        return true
    }
}

