//
//  LoginViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class LoginViewModel: BaseViewModel {

    let didLogin = BehaviorSubject<Bool>(value: false)
    
    func login(with email: String, password: String) {
        self.loading.value = true
        APIClient.login(with: email, password: password).subscribe { [unowned self] (event) in
            switch event {
            case .next(let token):
                AuthHelper.saveToken(token: token)
                self.didLogin.on(.next(true))
            case .error(let error):
                self.error.value = error
            case .completed:
                self.loading.value = false
            }
        }.disposed(by: disposeBag)
    }
    
}
