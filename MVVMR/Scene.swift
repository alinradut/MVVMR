//
//  Scene.swift
//  MVVMR
//
//  Created by Alin Radut on 11/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//
import UIKit

public struct Scene<VC: ViewController & UIViewController> {
    private(set) var viewController: VC
    private(set) var viewModel: VC.VM
    private(set) var router: VC.VM.R
    private(set) var parentController: UIViewController?
    
    init(parentController: UIViewController?, transition: Transition, setContext: ((VC.VM) -> Void)? = nil) {
        router = VC.VM.R.resolve(parentController: parentController, transition: transition)
        viewModel = VC.VM.resolve(router: router)

        setContext?(viewModel)
        viewController = VC.resolve()
        viewController.inject(viewModel: viewModel)
    }
    
    init(viewController: VC, viewModel: VC.VM, router: VC.VM.R) {
        self.viewController = viewController
        self.viewModel = viewModel
        self.router = router
    }
    
    public static func show(on parentController: UIViewController?, navigationStyle: NavigationStyle = .push, setContext: ((VC.VM) -> Void)? = nil) {
        let scene = Self.build(parentController: parentController, navigationStyle: navigationStyle, setContext: setContext)
        scene.router.presentationTransition?.run(to: scene.viewController)
    }
    
    public static func show(viewController: VC, viewModel: VC.VM, router: VC.VM.R) {
        let scene = Self.init(viewController: viewController, viewModel: viewModel, router: router)
        scene.router.presentationTransition?.run(to: scene.viewController)
    }
    
    public static func build(parentController: UIViewController?, navigationStyle: NavigationStyle = .push, setContext: ((VC.VM) -> Void)? = nil) -> Scene {
        let scene = Self.init(parentController: parentController, transition: navigationStyle.transition, setContext: setContext)
        return scene
    }
}
