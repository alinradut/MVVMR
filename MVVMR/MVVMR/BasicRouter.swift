//
//  BasicRouter.swift
//  MVVMR
//
//  Created by Alin Radut on 3/8/21.
//

import Foundation

/// The most basic router you can have. It takes a `Route` type as a generic, which can be an enum of valid routes.
public struct BasicRouter<T: Route>: Router {
    public typealias RouteType = T
    
    /// The controller this router and it's related view controller were presented on. To prevent accidental
    /// memory leaks, this should be declared as weak.
    public weak var navigationController: UINavigationController?
    
    /// The incoming transition that was used to display this scene. We keep a reference because
    /// we might want to reverse that transition at one point.
    public var presentationTransition: Transition?
    
    public init() {}
}

public typealias NullRouter = BasicRouter<NullRoute>

public enum NullRoute: Route {
    case none

    public func navigate(on navigationController: UINavigationController?) {
    }
}
