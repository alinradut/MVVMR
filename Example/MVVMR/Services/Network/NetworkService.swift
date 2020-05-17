//
//  NetworkService.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 17/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

protocol NetworkService {
    func login(username: String, password: String, onCompletion: @escaping ((Result<String, NetworkServiceError>) -> Void))
}

enum NetworkServiceError: Error {
    case badUsernameOrPassword
    
    var localizedDescription: String {
        switch self {
        case .badUsernameOrPassword:
            return "Bad username or password"
        }
    }
}

class FakeNetworkService: NetworkService {
    
    func login(username: String, password: String, onCompletion: @escaping ((Result<String, NetworkServiceError>) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if username == "error" {
                onCompletion(.failure(.badUsernameOrPassword))
                return
            }
            onCompletion(.success("fake-auth-token"))
        }
    }
}
