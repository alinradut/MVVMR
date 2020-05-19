//
//  DashboardCell.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 18/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class DashboardCell: UICollectionViewCell {
    
    @IBOutlet weak var iconLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    
    func bindViewModel() {
        
    }
    
    func unbindViewModel() {
        
    }
    
    override func prepareForReuse() {
        unbindViewModel()
    }
}
