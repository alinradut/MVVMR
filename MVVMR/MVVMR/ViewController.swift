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

    associatedtype ViewModelType: ViewModel
    
    /// Associated view model.
    ///
    /// The reason why this is an implicitly unwrapped optional is because we want to keep using
    /// the standard way of initializing a view controller, be that from init() or from a storyboard or nib.
    var viewModel: ViewModelType! { get set }

    func inject(viewModel: ViewModelType)
}

public extension ViewController where Self: UIViewController {
    
    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}

public extension ViewController where Self: UIViewController {
    
    /// Instantiate a new view controller from storyboard, nib or basic initializer.
    /// - Returns: An instance of the current class.
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
