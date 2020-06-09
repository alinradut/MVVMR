//
//  ViewModelBuilder.swift
//  MVVMR
//
//  Created by Alin Radut on 01/05/2020.
//  Copyright © 2020 Alin Radut. All rights reserved.
//

import Foundation

/// Factory for view models.
public class ViewModelBuilder {
    
    public static var `default` = ViewModelBuilder()
    
    public init() {}

    public func build<VM: ViewModel>(router: VM.RouterType, setContext: ((VM) -> Void)? = nil) -> VM {
        let viewModel = VM.init(router)
        setContext?(viewModel)
        return viewModel
    }
}
