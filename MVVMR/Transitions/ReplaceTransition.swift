//
//  ReplaceTransition.swift
//  MVVMR
//
//  Created by Alin Radut on 17/05/2020.
//

import Foundation
import UIKit

public class ReplaceTransition: NSObject, Transition {

    public var isAnimated: Bool
    var onCompletion: (() -> Void)?
    
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
    
    private var navigationController: UINavigationController?

    public init(isAnimated: Bool = true, onCompletion: (() -> Void)? = nil) {
        self.isAnimated = isAnimated
        self.onCompletion = onCompletion
    }

    public func run(to destinationController: UIViewController) {
        assert(navigationController != nil, "sourceController is not an UINavigationController and does not have an associated UINavigationController")
        navigationController?.setViewControllers([destinationController], animated: isAnimated)
    }
    
    public func reverse() {
    }
}
