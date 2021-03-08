//
//  NavigationStyle.swift
//  MVVMR
//
//  Created by Alin Radut on 3/8/21.
//

import Foundation

/// The navigation style to use when displaying a controller.
public enum NavigationStyle {
    
    // Will call `navigationController?.push(...)`
    case push
    
    // Will call `navigationController?.present`
    case modal
    
    // Will replace all view controllers in the navigation controller with the destination controller
    case replace
    
    // Will replace the key window's rootViewController
    case replaceWindowRoot(ReplaceWindowRootTransition.AnimationType)
    
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
        case .replaceWindowRoot(let animation):
            return ReplaceWindowRootTransition(animation)
        case .custom(let transition):
            return transition
        }
    }
}
