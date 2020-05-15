//
//  AppCoordinator.swift
//  Private
//
//  Created by Alin Radut on 06/12/2019.
//  Copyright © 2019 Alin Radut. All rights reserved.
//

import Foundation
import UIKit
import MVVMR

class AppCoordinator {
    
    enum State {
        case starting, locked, ready
    }
    
    var state: State = .starting
    var router: AppRouter
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        if window.rootViewController == nil {
            window.rootViewController = UINavigationController()
        }
        router = AppRouter(parentController: window.rootViewController!, transition: NavigationStyle.push.transition)
        start()
    }
    
    func start() {
        router.navigate(to: .mainScreen(1))
    }
}

