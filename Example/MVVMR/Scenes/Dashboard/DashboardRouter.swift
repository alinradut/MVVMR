//
//  DashboardRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 18/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct DashboardRouter: Router {
    
    /// The controller this router and it's related view controller were presented on.
    weak var navigationController: UINavigationController?
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    var presentationTransition: Transition?
    
    typealias RouteType = Routes
    
    enum Routes: Route {
        func navigate(on navigationController: UINavigationController?) {
            switch self {
            
            default:
                break
            }
        }
    }
}
