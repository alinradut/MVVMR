//
//  RegisterRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct RegisterRouter: Router {
    weak var parentController: UIViewController?
    
    var presentationTransition: Transition?
    
    typealias RouteType = Routes
    
    enum Routes: Route {
        case dashboard
        case errorAlert(title: String, message: String)

        func navigate(on parentController: UIViewController?) {
            switch self {
            case .dashboard:
                Scene<DashboardViewController>.show(on: parentController, navigationStyle: .replace)
            case .errorAlert(let title, let message):
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                let transition = ModalTransition()
                transition.sourceController = parentController
                transition.run(to: alert)
            default:
                break
            }
        }
    }
}
