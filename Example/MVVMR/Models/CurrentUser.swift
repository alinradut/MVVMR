//
//  CurrentUser.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

class CurrentUser {
    static var isLoggedIn: Bool {
        return profile != nil
    }
    
    static var profile: Profile?
}

struct Profile {
    var username: String
    var password: String
    var authToken: String
}
