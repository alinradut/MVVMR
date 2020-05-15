//
//  AppDelegate.swift
//  MVVMR
//
//  Created by Alin Radut on 05/15/2020.
//  Copyright (c) 2020 Alin Radut. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        return true
    }
}

