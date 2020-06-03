//
//  Router.swift
//  MVVMR
//
//  Created by Alin Radut on 30/04/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit


/// The navigation style to use when displaying a controller.
public enum NavigationStyle {
    
    // Will call `associatedController.navigationController?.push(...)`
    case push
    
    // Will call `associatedController.present`
    case modal
    
    // Will replace all view controllers in the navigation controller with the destination controller
    case replace
    
    // A custom presentation based on the associated transition.
    case custom(Transition)
    
    /// The associated transition.
    public var transition: Transition {
        switch self {
        case .push:
            return PushTransition()
        case .modal:
            return ModalTransition()
        case .replace:
            return ReplaceTransition()
        case .custom(let transition):
            return transition
        }
    }
}

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
    ///   - parentController: The parent controller on which we are supposed to show sub-routes.
    ///   - transition: Presentation transition
    init(navigationController: UINavigationController?, transition: Transition)

    /// Navigate to a route. The `route` will be asked to produce a view controller and the navigation style.
    /// If you need to pass a context to the target viewcontroller, do so via the `navigate(to:context:)` method.
    /// - Parameter route: Route
    func navigate(to route: RouteType)
    
    /// Go back by reversing the presentation transition.
    func navigateBack()
}

public extension Router {
    
    /// Initializer
    /// - Parameters:
    ///   - parentController: The parent controller on which we are supposed to show sub-routes.
    ///   - transition: Presentation trnasition
    init(navigationController: UINavigationController?, transition: Transition) {
        self.init()
        self.navigationController = navigationController
        self.presentationTransition = transition
        transition.sourceController = navigationController
    }
    
    /// Navigate to a route. The `route` will be asked to produce a view controller and the navigation style.
    /// If you need to pass a context to the target viewcontroller, do so via the `navigate(to:context:)` method.
    /// - Parameter route: Route
    func navigate(to route: RouteType) {
        route.navigate(on: navigationController)
    }
    
    /// Go back by reversing the presentation transition.
    func navigateBack() {
        presentationTransition?.reverse()
    }
}


extension Router {
    
    /// Instantiate this router along with an parent controller, upon which we will show the router's associated view controller,
    /// a transition and a builder (which defaults to RouterBuilder)
    /// - Parameters:
    ///   - navigationController: Parent controller on which to show routes stemming from this router.
    ///   - transition: Presentation transition
    ///   - builder: Builder object.
    /// - Returns: A configured router.
    static func resolve(navigationController: UINavigationController?, transition: Transition, builder: RouterBuilder = .default) -> Self {
        return builder.build(navigationController: navigationController, transition: transition)
    }
}
