//
//  RxNetworkService.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 18/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

struct RegisterResponse {
    let token: String
    let username: String
    let password: String
}

protocol RxNetworkService {
    func register(username: String, password: String) -> Single<RegisterResponse>
}

class FakeRxNetworkService: RxNetworkService {
    func register(username: String, password: String) -> Single<RegisterResponse> {
        return Single<RegisterResponse>.create { single in
            // call to backend
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if username == "error" {
                    single(.failure(NetworkServiceError.alreadyRegistered))
                }
                else {
                    single(.success(RegisterResponse(token: "TOKEN", username: username, password: password)))
                }
            }
            
            return Disposables.create()
        }
    }
}
