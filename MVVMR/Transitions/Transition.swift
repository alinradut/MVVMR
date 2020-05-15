//
//  Transition.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

public protocol Transition: AnyObject {
    var sourceController: UIViewController? { get set }
    
    func run(to destinationController: UIViewController)
    func reverse()
}

public protocol AnimatedTransition: Transition {
    var animator: Animator? { get set }
    var isAnimated: Bool { get set }
}

public protocol Animator: UIViewControllerAnimatedTransitioning {
    
}

