//
//  ViewController.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewController: class {

    associatedtype VM: ViewModel
    var viewModel: VM! { get set }
    
    init()
}

extension ViewController where Self: UIViewController {
    
    public func inject(viewModel: VM) {
        self.viewModel = viewModel
    }
}

extension ViewController where Self: UIViewController {
    static func resolve() -> Self {
        var viewController: Self
        
        if let storyboardInstantiable = self as? StoryboardInstantiable.Type {
            viewController = storyboardInstantiable.fromStoryboard()
        }
        else if let nibInstantiable = self as? NibInstantiable.Type {
            viewController = nibInstantiable.fromNib()
        }
        else {
            viewController = .init()
        }
        return viewController
    }
}
