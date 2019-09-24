//
//  AppDelegate.swift
//  CriticalTechWorks 2019
//
//  Created by Bruno on 17/09/2019.
//  Copyright © 2019 Bruno. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: TopHeadlinesViewController())
        
        return true
    }

}

