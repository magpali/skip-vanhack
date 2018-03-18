//
//  BaseViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class BaseViewModel: NSObject {
    let disposeBag = DisposeBag()
    
    let loading = Variable<Bool>(false)
    let error = Variable<Error?>(nil)
}
