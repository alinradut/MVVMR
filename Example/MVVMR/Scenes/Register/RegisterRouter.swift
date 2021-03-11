//
//  RegisterRouter.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

enum RegisterRoute: Route {
    case dashboard
    case errorAlert(title: String, message: String)

    func navigate(on navigationController: UINavigationController?) {
        switch self {
        case .dashboard:
            Scene<DashboardViewController>.show(on: navigationController, navigationStyle: .replace)
        case .errorAlert(let title, let message):
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            let transition = ModalTransition()
            transition.sourceController = navigationController
            transition.run(to: alert)
        }
    }
}
