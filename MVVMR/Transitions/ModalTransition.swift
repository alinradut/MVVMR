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
    
    weak var destinationController: UIViewController?
    public weak var sourceController: UIViewController?
    
    public init(animator: Animator? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen,
         onShow: (() -> Void)? = nil,
         onDismiss: (() -> Void)? = nil) {
        
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
        self.onShow = onShow
        self.onClose = onDismiss
    }

    public func run(to destinationController: UIViewController) {
        self.destinationController = destinationController
        
        destinationController.transitioningDelegate = self
        destinationController.modalTransitionStyle = modalTransitionStyle
        destinationController.modalPresentationStyle = modalPresentationStyle
    
        sourceController?.present(destinationController, animated: isAnimated, completion: onShow)
    }
    
    public func reverse() {
        sourceController?.dismiss(animated: isAnimated, completion: onClose)
    }
}

extension ModalTransition: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let animator = animator {
            return animator
        }
        return nil
    }
}


