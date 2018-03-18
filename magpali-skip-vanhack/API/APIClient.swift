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

}
