//
//  LoginViewController.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeModal))
        applyTexts()
        bind()
    }
    
    func applyTexts() {
        emailLabel.text = R.string.localizable.loginEmail()
        passwordLabel.text = R.string.localizable.loginPassword()
        loginButton.setTitle(R.string.localizable.loginSignin(), for: .normal)
        signUpButton.setTitle(R.string.localizable.loginSignup(), for: .normal)
    }
    
    func applyLayout() {
    }
    
    func bind() {
        
        Observable.combineLatest(emailTextField.rx.text.asObservable(),
                                 passwordTextField.rx.text.asObservable()) { (emailText, passwordText) -> Bool in
            guard let email = emailText?.trimmingCharacters(in: .whitespaces),
                let password = passwordText?.trimmingCharacters(in: .whitespaces) else { return false }
            return !email.isEmpty && !password.isEmpty
        }.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
            guard let email = self.emailTextField.text,
                let password = self.passwordTextField.text else { return }
            self.viewModel.login(with: email, password: password)
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
            self.navigationController?.pushViewController(SignUpViewController(), animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.didLogin.subscribe(onNext: { [unowned self] (value) in
            if value {
                self.closeModal()
            }
        }).disposed(by: disposeBag)
        
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
}
