//
//  ReplaceTransition.swift
//  MVVMR
//
//  Created by Alin Radut on 17/05/2020.
//

import Foundation
import UIKit

public class ReplaceTransition: NSObject, Transition {

    public var animator: Animator?
    public var isAnimated: Bool
    var onCompletion: (() -> Void)?
    var prependedControllers: [UIViewController] = []
    
    public weak var sourceController: UIViewController? {
        didSet {
            if let navigationController = sourceController?.navigationController {
                self.navigationController = navigationController
            }
            else if let navigationController = sourceController as? UINavigationController {
                self.navigationController = navigationController
            }
        }
    }
    
    private weak var navigationController: UINavigationController?

    public init(animator: Animator? = nil, isAnimated: Bool = true, prependedControllers: [UIViewController] = [], onCompletion: (() -> Void)? = nil) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.prependedControllers = prependedControllers
        self.onCompletion = onCompletion
    }

    public func run(to destinationController: UIViewController) {
        assert(navigationController != nil, "sourceController is not an UINavigationController and does not have an associated UINavigationController")
        navigationController?.delegate = self
        let controllers = prependedControllers + [destinationController]
        navigationController?.setViewControllers(controllers, animated: isAnimated)
    }
    
    public func reverse() {
    }
}

extension ReplaceTransition: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        onCompletion?()
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator, isAnimated else { return nil }
        
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}
