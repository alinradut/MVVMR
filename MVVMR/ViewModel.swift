//
//  ViewModel.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation

public protocol ViewModel {

    associatedtype R: Router
    var router: R? { get set }

    init()
    init(_ router: R?)
    func setContext(context: Any?)
}

public extension ViewModel {
    
    init(_ router: R?) {
        self.init()
        self.router = router
    }
    
    func setContext(context: Any?) {
        // override from subclass
    }
}

extension ViewModel {
    static func resolve(router: R, builder: ViewModelBuilder = .default) -> Self {
        return builder.build(router: router)
    }
}
