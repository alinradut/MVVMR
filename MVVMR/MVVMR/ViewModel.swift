//
//  ViewModel.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation

public protocol ViewModel {

    associatedtype RouterType: Router
    var router: RouterType { get set }

    init()
    init(router: RouterType)

    /// Replace the attached router,
    /// - Parameter router: Router
    mutating func inject(router: RouterType)

    /// Configure the attached router. Usually used to set or override the navigation controller or the transition.
    /// - Parameter configuration: Configuration block
    mutating func configureRouter(_ configuration: ((inout RouterType) -> Void))
}

public extension ViewModel {

    init(router: RouterType) {
        self.init()
        self.router = router
    }

    mutating func inject(router: RouterType) {
        self.router = router
    }

    mutating func configureRouter(_ configuration: ((inout RouterType) -> Void)) {
        configuration(&router)
    }
}

public extension ViewModel {
    static func resolve(builder: ViewModelBuilder = .default) -> Self {
        return builder.build()
    }
}
