//
//  Router.swift
//  MVVMR
//
//  Created by Alin Radut on 30/04/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

/// Basic route protocol which is usually associated with a router.
public protocol Route {
    
    /// Navigate this route. The route is responsible for instantiating the appropriate scene and displaying
    /// it on the `navigationController`.
    /// - Parameter navigationController: The controller on which we should present the associated view controller.
    func navigate(on navigationController: UINavigationController?)
}

public protocol Router {
    
    associatedtype RouteType: Route
    
    /// The controller this router and it's related view controller were presented on. To prevent accidental
    /// memory leaks, this should be declared as weak.
    var navigationController: UINavigationController? { get set }
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    var presentationTransition: Transition? { get set }
    
    init()
    /// Initializer
    /// - Parameters:
    ///   - navigationController: The parent controller on which we are supposed to show sub-routes.
    ///   - transition: Presentation transition
    init(navigationController: UINavigationController?, transition: Transition)

    /// Update the attached navigation controller and transition.
    /// - Parameters:
    ///   - navigationController: The parent controller on which we are supposed to show sub-routes.
    ///   - transition: Presentation transition
    mutating func configure(navigationController: UINavigationController?, transition: Transition)

    /// Navigate to a route. The `route` will be have to handle the navigation in it's `navigate(on:)` method.
    /// - Parameter route: RouteType
    func navigate(to route: RouteType)
    
    /// Go back by reversing the presentation transition.
    func navigateBack()
    
    /// Present an alert object
    func showAlert(_ alert: Alert)
}

public extension Router {
    
    /// Initializer
    /// - Parameters:
    ///   - parentController: The parent controller on which we are supposed to show sub-routes.
    ///   - transition: Presentation trnasition
    init(navigationController: UINavigationController?, transition: Transition) {
        self.init()
        configure(navigationController: navigationController, transition: transition)
    }

    mutating func configure(navigationController: UINavigationController?, transition: Transition) {
        self.navigationController = navigationController
        self.presentationTransition = transition
        if transition.sourceController == nil {
            transition.sourceController = navigationController
        }
    }
    
    /// Navigate to a route. The `route` will be asked to produce a view controller and the navigation style.
    /// If you need to pass a context to the target view controller, do so via the `ViewController.ViewModel.setContext`
    /// method
    /// - Parameter route: Route
    func navigate(to route: RouteType) {
        route.navigate(on: navigationController)
    }
    
    /// Go back by reversing the presentation transition.
    func navigateBack() {
        presentationTransition?.reverse()
    }
    
    /// Present an alert object
    func showAlert(_ alert: Alert) {
        if let currentModal = navigationController?.presentedViewController {
            currentModal.present(alert.alertController, animated: alert.animated, completion: alert.completion)
        } else {
            navigationController?.present(alert.alertController, animated: alert.animated, completion: alert.completion)
        }
    }
}
