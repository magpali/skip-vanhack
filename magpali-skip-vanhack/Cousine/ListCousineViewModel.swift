//
//  ListCousineViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class ListCousineViewModel: BaseViewModel {

    let cousines: Variable<[Cousine]> = Variable<[Cousine]>([])
    
    override init() {
        super.init()
        listCousine()
    }
    
    func listCousine() {
        self.loading.value = true
        APIClient.listCousine().subscribe { [weak self] (event) in
            switch event {
            case .next(let cousines):
                self?.error.value = nil
                self?.cousines.value = cousines
            case .error(let error):
                self?.error.value = error
            case .completed:
                self?.loading.value = false
            }
        }.disposed(by: disposeBag)
    }
    
}
