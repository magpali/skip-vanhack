//
//  SignUpViewController.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!

    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeModal))
        bind()
    }
    
    func bind() {
        
        Observable.combineLatest(emailTextField.rx.text.asObservable(),
                                 nameTextField.rx.text.asObservable(),
                                 addressTextField.rx.text.asObservable(),
                                 passwordTextField.rx.text.asObservable()) { (emailText, nameText, addressText, passwordText) -> Bool in
                                    guard let email = emailText?.trimmingCharacters(in: .whitespaces),
                                        let name = nameText?.trimmingCharacters(in: .whitespaces),
                                        let address = addressText?.trimmingCharacters(in: .whitespaces),
                                        let password = passwordText?.trimmingCharacters(in: .whitespaces) else { return false }
                                    return !email.isEmpty && !name.isEmpty  && !address.isEmpty  && !password.isEmpty
            }.bind(to: signUpButton.rx.isEnabled).disposed(by: disposeBag)
        
        signUpButton.rx.tap.asObservable().subscribe(onNext: { [unowned self] (_) in
            guard let email = self.emailTextField.text,
                let name = self.nameTextField.text,
                let address = self.addressTextField.text,
                let password = self.passwordTextField.text else { return }
            self.viewModel.signUp(with: email, name: name, address: address, password: password)
        }).disposed(by: disposeBag)
        
        viewModel.didSignUp.subscribe(onNext: { [unowned self] (value) in
            if value {
                self.closeModal()
            }
        }).disposed(by: disposeBag)
    }

    @objc func closeModal() {
        dismiss(animated: true, completion: nil)
    }

}
