//
//  AppDelegate.swift
//  mapdownloader
//
//  Created by ankudinov aleksandr on 03.07.2023.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DependencyManager.BuldDependecy()
        
        return true
    }


}

