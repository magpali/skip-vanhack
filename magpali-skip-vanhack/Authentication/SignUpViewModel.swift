//
//  SignUpViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class SignUpViewModel: BaseViewModel {
    
    let didSignUp = BehaviorSubject<Bool>(value: false)
    
    func signUp(with email: String, name: String, address: String, password: String) {
        self.loading.value = true
        APIClient.signUp(with: email, name: name, address: address, password: password).subscribe { [unowned self] (event) in
            switch event {
            case .next(let authToken):
                AuthHelper.saveToken(token: authToken)
                self.didSignUp.on(.next(true))
            case .error(let error):
                self.error.value = error
            case .completed:
                self.loading.value = false
            }
        }.disposed(by: disposeBag)
    }

}
