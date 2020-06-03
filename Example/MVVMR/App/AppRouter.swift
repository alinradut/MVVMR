//
//  AppRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct AppRouter: Router {
    
    init() {}
    
    var presentationTransition: Transition?
    var navigationController: UINavigationController?
    
    typealias RouteType = Routes
    
    enum Routes: Route {
        case login
        case dashboard
        
        var navigationStyle: NavigationStyle {
            return .push
        }
        
        func navigate(on navigationController: UINavigationController?) {
            switch self {
            case .login:
                Scene<LoginViewController>.show(on: navigationController)
            case .dashboard:
                Scene<DashboardViewController>.show(on: navigationController, navigationStyle: navigationStyle)
            }
        }
    }
}
