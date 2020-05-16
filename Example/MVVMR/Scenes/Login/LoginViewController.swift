//
//  LoginViewController.swift
//  MVVMR_Example
//
//  Created by Alin Radut on 15/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import MVVMR
//import SimpleTwoWayBinding

class LoginViewController: UIViewController, ViewController, StoryboardInstantiable {
    
    var viewModel: LoginViewModel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        bindViewModel()
    }
    
    private func bindViewModel() {
//        usernameTextField.bind(with: viewModel.username)
//        passwordTextField.bind(with: viewModel.password)
    }
}

extension LoginViewController {
    @IBAction func onRegisterBtnTapped() {
        viewModel.onRegister()
    }
}
