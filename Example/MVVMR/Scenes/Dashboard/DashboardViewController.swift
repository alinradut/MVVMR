//
//  DashboardViewController.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 18/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

class DashboardViewController: UICollectionViewController, ViewController, StoryboardInstantiable {
    
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
}
