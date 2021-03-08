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
    var router: RouterType? { get set }

    init()
    init(_ router: RouterType?)
}

public extension ViewModel {
    
    init(_ router: RouterType?) {
        self.init()
        self.router = router
    }
}

public extension ViewModel {
    static func resolve(router: RouterType, builder: ViewModelBuilder = .default) -> Self {
        return builder.build(router: router)
    }
}
