//
//  APIClient.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift
import Moya

let DefaultProvider = MoyaProvider<DefaultTarget>(plugins: [ NetworkLoggerPlugin(verbose: true)])

class APIClient {
    
    static func listCousine() -> Observable<[Cousine]> {
        return DefaultProvider.rx.request(.listCousine())
            .map([Cousine].self)
            .asObservable()
    }
    
    static func listStore(by cousineId: Int) -> Observable<[Store]> {
        return DefaultProvider.rx.request(.listStore(cousineId: cousineId))
            .map([Store].self)
            .asObservable()
    }
    
    static func listProducts(by storeId: Int) -> Observable<[Product]> {
        return DefaultProvider.rx.request(.listProducts(storeId: storeId))
            .map([Product].self)
            .asObservable()
    }
    
    static func login(with email: String, password: String) -> Observable<String> {
        return DefaultProvider.rx.request(.login(email: email, password: password))
            .mapString()
            .asObservable()
    }
    
    static func signUp(with email: String, name: String, address: String, password: String) -> Observable<String> {
        return DefaultProvider.rx.request(.signUp(email: email, name: name, address: address, password: password))
            .mapString()
            .asObservable()
    }

}
