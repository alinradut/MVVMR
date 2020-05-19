//
//  RegisterViewController.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR
import RxSwift

class RegisterViewController: UIViewController, ViewController, NibInstantiable {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var viewModel: RegisterViewModel!
    private var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        disposeBag.insert([
            usernameTextField.rx.text.orEmpty.bind(to: viewModel.username),
            passwordTextField.rx.text.orEmpty.bind(to: viewModel.password),
            confirmPasswordTextField.rx.text.orEmpty.bind(to: viewModel.confirmPassword),
            registerButton.rx.tap.bind(onNext: { [weak self] in self?.viewModel.onRegister()}),
            viewModel.isValid.bind(to: registerButton.rx.isEnabled),
            viewModel.isRegistering.bind(onNext: { UIApplication.shared.isNetworkActivityIndicatorVisible = $0; print("is registering: \($0)") }),
            viewModel.didFailSignIn.bind(onNext: { error in print("error: \(error)")})
        ])
        
    }
}

extension RegisterViewController {
    @IBAction func onBackToLoginBtnTapped(_ sender: Any) {
        viewModel.onBack()
    }
}
