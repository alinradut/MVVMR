//
//  UIViewController-Instantiable.swift
//  MVVMR
//
//  Created by Alin Radut on 06/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardInstantiable: AnyObject {
    
    /// The storyboard file name. If `ownsStoryboard` is true, it will be the current class name, otherwise
    /// it will be `Main`. This is useful to override when the the current class has a generic attached to it.
    static var storyboardName: String { get }
    
    /// The storyboard to use to load this controller. The default storyboard will be "Main".
    static var storyboard: UIStoryboard { get }
    
    /// The storyboard identifier to use to load this controller. The default storyboard identifier will be the class name
    static var storyboardIdentifier: String { get }
    
    /// If this flag is true, `storyboardIdentifier` will not be used.
    static var isInitialViewControllerInStoryboard: Bool { get }
    
    /// If this flag is true, the storyboard with the same name will be used.
    /// E.g., if this is `LoginViewController` and `ownsStoryboard` is true, we will
    /// use `LoginViewController.storyboard`.
    static var ownsStoryboard: Bool { get }
    
    /// Instantiates a new controller from the `storyboard` with `storyboardIdentifier`
    /// - Returns: UIViewController
    static func fromStoryboard<VC: UIViewController>() -> VC
}

public protocol NibInstantiable {
    /// The nib name to use to load the controller. By default it will be the current class name.
    static var nibName: String { get }
    
    /// Instantiates a new controller from `nibName`
    /// - Returns: UIViewController
    static func fromNib<VC: UIViewController>() -> VC
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardName: String {
        if ownsStoryboard {
            return self.nameWithoutGenerics()
        }
        return "Main"
    }
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
    }
    
    static var storyboardIdentifier: String {
        return self.nameWithoutGenerics()
    }
    
    static var ownsStoryboard: Bool {
        return true
    }
    
    static var isInitialViewControllerInStoryboard: Bool {
        return false
    }
    
    static func fromStoryboard<VC: UIViewController>() -> VC {
        if isInitialViewControllerInStoryboard {
            return storyboard.instantiateInitialViewController() as! VC
        }
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! VC
    }
}

public extension NibInstantiable where Self: UIViewController {
    
    static var nibName: String {
        return self.nameWithoutGenerics()
    }
    
    static func fromNib<VC: UIViewController>() -> VC {
        return VC.init(nibName: nibName, bundle: Bundle(for: self))
    }
}

extension UIViewController {
    public static func nameWithoutGenerics() -> String {
        var name = String(describing: self)
        if let range = name.range(of: "<") {
            name = String(name.prefix(upTo: range.lowerBound))
        }
        return name
    }
}
