//
//  ModalTransition.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

public class ModalTransition: NSObject, AnimatedTransition {

    public var animator: Animator?
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle

    public var isAnimated: Bool

    public var onShow: (() -> Void)?
    public var onClose: (() -> Void)?

    public var embeddingBlock: ((UIViewController) -> UIViewController)?

    weak var destinationController: UIViewController?
    public weak var sourceController: UIViewController?

    /// Create a new modal transition object.
    /// - Parameters:
    ///   - animator: Animator object (optional). Used for custom transitions.
    ///   - isAnimated: Whether to animate the transition.
    ///   - modalTransitionStyle: Transition style.
    ///   - modalPresentationStyle: Modal presentation style.
    ///   - onShow: Block to execute when the incoming transition finished executing.
    ///   - onDismiss: Block to execute when the dismissal transition finished.
    ///   Executed only when reverse() is called.
    ///   - embeddingBlock: Helper block called to transform the `destinationController`
    ///   into another controller instance. Useful to wrap it into a navigation
    ///   controller, for example.
    public init(animator: Animator? = nil,
                isAnimated: Bool = true,
                modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
                modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
                onShow: (() -> Void)? = nil,
                onDismiss: (() -> Void)? = nil,
                embeddingBlock: ((UIViewController) -> UIViewController)? = nil) {

        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
        self.onShow = onShow
        self.onClose = onDismiss
        self.embeddingBlock = embeddingBlock
    }

    public func run(to destinationController: UIViewController) {
        let controller = embeddingBlock?(destinationController) ?? destinationController

        controller.transitioningDelegate = self
        controller.modalTransitionStyle = modalTransitionStyle
        controller.modalPresentationStyle = modalPresentationStyle

        self.destinationController = controller
        sourceController?.present(controller, animated: isAnimated, completion: onShow)
    }

    public func reverse() {
        sourceController?.dismiss(animated: isAnimated, completion: onClose)
    }
}

extension ModalTransition: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let animator = animator {
            animator.isPresenting = true
            return animator
        }
        return nil
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let animator = animator {
            animator.isPresenting = false
            return animator
        }
        return nil
    }
}


