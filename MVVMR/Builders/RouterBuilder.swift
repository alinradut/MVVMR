//
//  RouterBuilder.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

/// Factory for routers.
public class RouterBuilder {
    
    public static var `default` = RouterBuilder()

    public init() {}

    public func build<R: Router>(parentController: UIViewController?, transition: Transition) -> R {
        let router = R.init(parentController: parentController, transition: transition)
        return router
    }
}
