//
//  ViewControllerBuilder.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import UIKit

/// Factory for view controllers.
public class ViewControllerBuilder {
    
    public static var `default` = ViewControllerBuilder()

    var routerBuilder: RouterBuilder
    var viewModelBuilder: ViewModelBuilder
    
    public init(routerBuilder: RouterBuilder = .default, viewModelBuilder: ViewModelBuilder = .default) {
        self.routerBuilder = routerBuilder
        self.viewModelBuilder = viewModelBuilder
    }
    
    public func build<VC: ViewController & UIViewController>(navigationController: UINavigationController, transition: Transition) -> VC {
        let router: VC.ViewModelType.RouterType = .resolve(navigationController: navigationController, transition: transition)
        
        return build(router: router)
    }
    
    public func build<VC: ViewController & UIViewController>(router: VC.ViewModelType.RouterType) -> VC {
        let viewModel: VC.ViewModelType = .resolve(router: router, builder: viewModelBuilder)
        
        return build(viewModel: viewModel)
    }
    
    public func build<VC: ViewController & UIViewController>(viewModel: VC.ViewModelType) -> VC {
        let viewController: VC = .resolve()
        viewController.inject(viewModel: viewModel)
        
        return viewController
    }
}
