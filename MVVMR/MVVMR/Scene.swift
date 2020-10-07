//
//  Scene.swift
//  MVVMR
//
//  Created by Alin Radut on 11/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//
import UIKit

public struct Scene<VC: ViewController & UIViewController> {
    public private(set) var viewController: VC
    public private(set) var viewModel: VC.ViewModelType
    public private(set) var router: VC.ViewModelType.RouterType
    public private(set) var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?, transition: Transition, setContext: ((VC.ViewModelType) -> Void)? = nil) {
        router = VC.ViewModelType.RouterType.resolve(navigationController: navigationController, transition: transition)
        viewModel = VC.ViewModelType.resolve(router: router)

        setContext?(viewModel)
        viewController = VC.resolve()
        viewController.inject(viewModel: viewModel)
    }
    
    init(viewController: VC, viewModel: VC.ViewModelType, router: VC.ViewModelType.RouterType) {
        self.viewController = viewController
        self.viewModel = viewModel
        self.router = router
    }
    
    public static func show(on navigationController: UINavigationController?, navigationStyle: NavigationStyle = .push, setContext: ((VC.ViewModelType) -> Void)? = nil) {
        let scene = Self.build(navigationController: navigationController, navigationStyle: navigationStyle, setContext: setContext)
        scene.router.presentationTransition?.run(to: scene.viewController)
    }
    
    public static func show(viewController: VC, viewModel: VC.ViewModelType, router: VC.ViewModelType.RouterType) {
        let scene = Self.init(viewController: viewController, viewModel: viewModel, router: router)
        scene.router.presentationTransition?.run(to: scene.viewController)
    }
    
    public static func build(navigationController: UINavigationController? = nil, navigationStyle: NavigationStyle = .push, setContext: ((VC.ViewModelType) -> Void)? = nil) -> Scene {
        let scene = Self.init(navigationController: navigationController, transition: navigationStyle.transition, setContext: setContext)
        return scene
    }
}