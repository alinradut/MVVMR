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
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        router = AppRouter(navigationController: navigationController, transition: NavigationStyle.push.transition)
        start()
    }
    
    func start() {
        router.navigate(to: CurrentUser.isLoggedIn ? .dashboard : .login)
    }
}

