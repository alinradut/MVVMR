//
//  ReplaceWindowRootTransition.swift
//  MVVMR
//
//  Created by Alin Radut on 03/06/2020.
//

import Foundation
import UIKit

public class ReplaceWindowRootTransition: NSObject, Transition {
    
    public enum AnimationType {
        case none, pushFromRight, pushFromLeft, pushFromBottom, pushFromTop, fade
    }
    
    public var sourceController: UIViewController?
    public var isAnimated: Bool
    public var animationType: AnimationType
    
    var onCompletion: (() -> Void)?
    
    private var window: UIWindow? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return keyWindow
        }
        return UIApplication.shared.keyWindow
    }
    
    public init(_ animationType: AnimationType = .pushFromRight, onCompletion: (() -> Void)? = nil) {
        self.animationType = animationType
        self.onCompletion = onCompletion
        isAnimated = animationType != .none
    }
    
    public func run(to destinationController: UIViewController) {
        guard let window = self.window else {
            return
        }
        
        var destinationController = destinationController
        if destinationController.navigationController != nil {
            destinationController = destinationController.navigationController!
        }
        
        let sourceController = window.rootViewController
        
        var sourceControllerFinalPosition: CGRect = window.bounds
        
        switch animationType {
        case .fade:
            destinationController.view.alpha = 0
        case .pushFromRight:
            destinationController.view.frame = window.bounds.offsetBy(dx: window.frame.width, dy: 0)
            sourceControllerFinalPosition = window.bounds.offsetBy(dx: -window.frame.width, dy: 0)
        case .pushFromLeft:
            destinationController.view.frame = window.bounds.offsetBy(dx: -window.frame.width, dy: 0)
            sourceControllerFinalPosition = window.bounds.offsetBy(dx: window.frame.width, dy: 0)
        case .pushFromTop:
            destinationController.view.frame = window.bounds.offsetBy(dx: 0, dy: -window.frame.height)
            sourceControllerFinalPosition = window.bounds.offsetBy(dx: 0, dy: window.frame.height)
        case .pushFromBottom:
            destinationController.view.frame = window.bounds.offsetBy(dx: 0, dy: window.frame.height)
            sourceControllerFinalPosition = window.bounds.offsetBy(dx: 0, dy: -window.frame.height)
        default:
            break
        }
        
        destinationController.beginAppearanceTransition(true, animated: isAnimated)
        sourceController?.beginAppearanceTransition(false, animated: isAnimated)
        window.addSubview(destinationController.view)
        
        UIView.animate(withDuration: 0.4, animations: {
            destinationController.view.alpha = 1
            sourceController?.view.frame = sourceControllerFinalPosition
            destinationController.view.frame = window.bounds
        }) { (isCompleted) in
            if isCompleted {
                window.rootViewController = destinationController
                self.onCompletion?()
            }
        }
    }
    
    public func reverse() {
    }
}
