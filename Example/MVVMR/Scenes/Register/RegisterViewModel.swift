//
//  RegisterViewModel.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR
import RxSwift
import RxCocoa

class RegisterViewModel: ViewModel {
    
    var router: BasicRouter<RegisterRoute> = .init()
    var isValid: Observable<Bool>
    var isRegistering: BehaviorRelay<Bool> = .init(value: false)
    var username: BehaviorSubject<String> = .init(value: "")
    var password: BehaviorSubject<String> = .init(value: "")
    var confirmPassword: BehaviorSubject<String> = .init(value: "")
    let didFailSignIn = PublishSubject<Error>()
    
    private let disposeBag = DisposeBag()

    private var networkService: RxNetworkService = FakeRxNetworkService()

    required init() {
        isValid = Observable.combineLatest(username, password, confirmPassword).map({ (username, password, confirmPassword) -> Bool in
            guard !username.isEmpty,
                !password.isEmpty,
                !confirmPassword.isEmpty else {
                return false
            }
            guard password == confirmPassword else {
                return false
            }
            return true
        })
    }
    
    func onRegister() {
        isRegistering.accept(true)
        networkService.register(username: try! username.value(), password: try! password.value())
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
            self?.isRegistering.accept(false)
            CurrentUser.profile = Profile(username: response.username, password: response.password, authToken: response.token)
            self?.router.navigate(to: .dashboard)
        }) { [weak self] (error) in
            self?.isRegistering.accept(false)
            self?.didFailSignIn.onNext(error)
            self?.router.navigate(to: .errorAlert(title: "Error", message: error.localizedDescription))
        }.disposed(by: disposeBag)
    }
        
    func onBack() {
        router.navigateBack()
    }
}
