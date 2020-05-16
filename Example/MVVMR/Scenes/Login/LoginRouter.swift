//
//  LoginRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct LoginRouter: Router {
    
    /// The controller this router and it's related view controller were presented on.
    var parentController: UIViewController?
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    var presentationTransition: Transition?
    
    typealias R = Routes
    
    enum Routes: Route {
        
        case register
        
        func navigate(on parentController: UIViewController?) {
            switch self {
            case .register:
                Scene<RegisterViewController>.show(on: parentController)
            default:
                break
            }
        }
    }
}
