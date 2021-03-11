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
    weak var navigationController: UINavigationController?
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    var presentationTransition: Transition?
    
    typealias RouteType = Route
    
    enum Route: MVVMR.Route {
        
        case register
        case errorAlert(title: String, message: String)
        case dashboard
        
        func navigate(on navigationController: UINavigationController?) {
            switch self {
            case .register:
                Scene<RegisterViewController>.show(
                    on: navigationController,
                    navigationStyle: .custom(
                        PushTransition(animator: VerticalTransitionAnimator(),
                                       isAnimated: true,
                                       onCompletion: nil)
                    ))
                
            case .errorAlert(let title, let message):
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                let transition = ModalTransition()
                transition.sourceController = navigationController
                transition.run(to: alert)
            case .dashboard:
                Scene<DashboardViewController>.show(on: navigationController, navigationStyle: .replace)
            default:
                break
            }
        }
    }
}
