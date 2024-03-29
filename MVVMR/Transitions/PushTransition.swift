//
//  PushTransition.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

public class PushTransition: NSObject, AnimatedTransition {

    public var animator: Animator?
    public var isAnimated: Bool
    var onCompletion: (() -> Void)?

    public weak var sourceController: UIViewController? {
        didSet {
            if let navigationController = sourceController as? UINavigationController {
                self.navigationController = navigationController
            }
            else if let navigationController = sourceController?.navigationController {
                self.navigationController = navigationController
            }
        }
    }

    private weak var navigationController: UINavigationController?
    private weak var originalDelegate: UINavigationControllerDelegate?
    private weak var originalIPGRDelegate: UIGestureRecognizerDelegate?

    public init(animator: Animator? = nil, isAnimated: Bool = true, onCompletion: (() -> Void)? = nil) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.onCompletion = onCompletion
    }

    deinit {
        if originalDelegate != nil {
            navigationController?.delegate = originalDelegate
        }
        if originalIPGRDelegate != nil {
            navigationController?.interactivePopGestureRecognizer?.delegate = originalIPGRDelegate
        }
    }

    public func run(to destinationController: UIViewController) {
        assert(navigationController != nil, "sourceController is not an UINavigationController and does not have an associated UINavigationController")

        if onCompletion != nil {
            originalDelegate = navigationController?.delegate
            navigationController?.delegate = self
        }

        originalIPGRDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
        navigationController?.interactivePopGestureRecognizer?.delegate = self

        navigationController?.pushViewController(destinationController, animated: isAnimated)
    }

    public func reverse() {
        navigationController?.popViewController(animated: isAnimated)
    }
}

extension PushTransition: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {

        onCompletion?()
        originalDelegate?.navigationController?(navigationController, didShow: viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {

        originalDelegate?.navigationController?(navigationController, willShow: viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {

        originalDelegate?.navigationController?(navigationController, interactionControllerFor: animationController)
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

extension PushTransition: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
