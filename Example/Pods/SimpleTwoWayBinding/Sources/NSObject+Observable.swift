//
//  NSObject+Observable.swift
//  SimpleTwoWayBinding
//
//  Created by Manish Katoch on 11/26/17.
//

import Foundation

extension NSObject {
    @discardableResult
    public func observe<T>(for observable: Observable<T>, with: @escaping (T) -> ()) -> BindingReceipt {
        observable.bind { observable, value  in
            DispatchQueue.main.async {
                with(value)
            }
        }
    }
}
