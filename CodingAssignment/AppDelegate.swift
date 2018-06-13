//
//  AppDelegate.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Create a window and with Screen's Bounds
        window = UIWindow(frame: UIScreen.main.bounds)
        // Embed HomeTableViewController in Naviagtion Controller
        let homeVC = UINavigationController(rootViewController: HomeTableViewController())
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
        
        return true
    }


}

