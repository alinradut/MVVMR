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
    
    public func build<VC: ViewController & UIViewController>(context: Any? = nil, parentController: UIViewController, transition: Transition) -> VC {
        let router: VC.VM.R = .resolve(parentController: parentController, transition: transition)
        
        return build(context: context, router: router)
    }
    
    public func build<VC: ViewController & UIViewController>(context: Any? = nil, router: VC.VM.R) -> VC {
        let viewModel: VC.VM = .resolve(router: router, builder: viewModelBuilder)
        viewModel.setContext(context: context)
        
        return build(viewModel: viewModel)
    }
    
    public func build<VC: ViewController & UIViewController>(viewModel: VC.VM) -> VC {
        let viewController: VC = .resolve()
        viewController.inject(viewModel: viewModel)
        
        return viewController
    }
}
