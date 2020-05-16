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
    var parentController: UIViewController?
    
    typealias R = Routes
    
    enum Routes: Route {
        case login
        case dashboard
        
        var navigationStyle: NavigationStyle {
            return .push
        }
        
        func navigate(on parentController: UIViewController?) {
            switch self {
            case .login:
                Scene<LoginViewController>.show(on: parentController)
            case .dashboard:
                Scene<DashboardViewController>.show(on: parentController, navigationStyle: navigationStyle) 
            }
        }
    }
}
