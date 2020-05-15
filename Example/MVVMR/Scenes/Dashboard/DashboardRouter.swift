//
//  DashboardRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct DashboardRouter: Router {
    var parentController: UIViewController?
    
    var presentationTransition: Transition?
    
    typealias R = Routes    
    
    enum Routes: Route {
        func navigate(on parentController: UIViewController?) {
        }
    }
}
