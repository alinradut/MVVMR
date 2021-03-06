//
//  Alert.swift
//  MVVMR
//
//  Created by Alin Radut on 07/07/2020.
//

import Foundation
import UIKit

/// An abstracted representation of `UIAlertController`. This can be used to avoid dealing with the alert presentation
/// API in the view model.
open class Alert {
    
    struct Button {
        var title: String
        var action: (() -> Void)?
        var style: UIAlertAction.Style = .default
    }
    
    open var title: String?
    open var message: String?
    
    open var animated: Bool = true
    open var completion: (() -> Void)? = nil
    open var style: UIAlertController.Style
    
    var alertController: UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: style)
        buttons.forEach { button in
            controller.addAction(.init(title: button.title, style: button.style, handler: { _ in button.action?() }))
        }
        textFieldConfigurationBlocks.forEach {
            controller.addTextField(configurationHandler: $0)
        }
        return controller
    }
    
    private var buttons: [Button] = []
    private var textFieldConfigurationBlocks: [((UITextField) -> Void)] = []
    
    public init(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert) {
        self.title = title
        self.message = message
        self.style = style
    }
    
    @discardableResult
    open func addButton(
        title: String, action: (() -> Void)? = nil,
        style: UIAlertAction.Style = .default) -> Alert {
        buttons.append(.init(title: title, action: action, style: style))
        return self
    }
    
    @discardableResult
    open func addTextField(with configurationBlock: @escaping ((UITextField) -> Void)) -> Alert {
        self.textFieldConfigurationBlocks.append(configurationBlock)
        return self
    }
    
    open func show(on controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        controller.present(alertController, animated: animated, completion: completion)
    }
}
