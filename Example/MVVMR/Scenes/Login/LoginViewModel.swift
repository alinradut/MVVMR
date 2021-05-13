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

class LoginViewModel: ViewModel {
    
    var router: LoginRouter = .init()
    let username: Observable<String> = .init()
    let password: Observable<String> = .init()
    let isValid: Observable<Bool>
    let isWorking: Observable<Bool> = .init(false)
    
    private var networkService: NetworkService = FakeNetworkService()
    
    required init() {
        isValid = zip(username, password).map { (username, password) -> Bool in
            guard let username = username, !username.isEmpty else {
                return false
            }
            guard let password = password, !password.isEmpty else {
                return false
            }
            return true
        }.distinct()
    }
    
    func onLogin() {

        guard let username = username.value, !username.isEmpty else {
            router.navigate(to: .errorAlert(title: "Error", message: "Please enter a username"))
            return
        }
        
        guard let password = password.value, !password.isEmpty else {
            router.navigate(to: .errorAlert(title: "Error", message: "Please enter a password"))
            return
        }
        
        isWorking.value = true
        networkService.login(username: username, password: password) { [weak self] (result) in
            self?.isWorking.value = false
            switch result {
            case .failure(let error):
                self?.router.navigate(to: .errorAlert(title: "Error", message: error.localizedDescription))
            case .success(let authToken):
                CurrentUser.profile = Profile(username: username, password: password, authToken: authToken)
                self?.router.navigate(to: .dashboard)
            }
        }
    }
    
    func onRegister() {
        router.navigate(to: .register)
    }
}
