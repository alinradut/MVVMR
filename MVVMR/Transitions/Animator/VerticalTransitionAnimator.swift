//
//  VerticalTransitionAnimator.swift
//  MVVMR
//
//  Created by Alin Radut on 12/06/2020.
//

import Foundation
import UIKit

open class VerticalTransitionAnimator: NSObject, Animator {
    
    public enum Direction {
        case up, down
    }
    
    /// Whether this is a presentation or a dismissal (push/pop).
    open var isPresenting: Bool = true
    
    open var duration = 0.4
    
    /// The direction in which the source controller will go towards during the push transition.
    open var direction: Direction
    
    public init(isPresenting: Bool = true, direction: Direction = .down) {
        self.isPresenting = isPresenting
        self.direction = direction
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let multiplier: CGFloat = direction == .up ? -1.0 : 1.0
        
        toView.frame = isPresenting
            ? CGRect(x: 0, y: -1.0 * multiplier * fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
            : CGRect(x: 0, y: multiplier * fromView.frame.height, width: toView.frame.width, height: toView.frame.height)
        
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            toView.frame = fromView.frame

            fromView.frame = self.isPresenting
                ? CGRect(x: 0, y: multiplier * fromView.frame.height, width: fromView.frame.width, height: fromView.frame.height)
                : CGRect(x: 0, y: -1.0 * multiplier * fromView.frame.height, width: fromView.frame.width, height: fromView.frame.height)
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
