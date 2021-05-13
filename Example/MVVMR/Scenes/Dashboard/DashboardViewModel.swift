//
//  DashboardViewModel.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 18/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR

struct DashboardViewModel: ViewModel {
    
    var router: DashboardRouter = DashboardRouter()
    
    var categories: [Category] = []
}
