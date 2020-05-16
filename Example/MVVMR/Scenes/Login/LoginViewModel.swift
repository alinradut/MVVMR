//
//  LoginViewModel.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR
import SimpleTwoWayBinding

struct LoginViewModel: ViewModel {
    
    var router: LoginRouter?
    let username: Observable<String> = .init()
    let password: Observable<String> = .init()
    
    init() {
        username.bind { (observable, value) in
            print("username: \(value)")
        }
    }
    
    func onLogin() {
        print("\(username.value)")
    }
    
    func onRegister() {
        router?.navigate(to: .register)
    }
}
