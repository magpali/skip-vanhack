//
//  ListStoresViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class ListStoresViewModel: BaseViewModel {

    private let cousineId: Variable<Int>
    var stores = Variable<[Store]>([])
    
    init(cousineId: Int) {
        self.cousineId = Variable<Int>(cousineId)
        super.init()
        listStores(by: cousineId)
        bind()
    }
    
    func bind() {
        cousineId.asObservable().subscribe(onNext: { [weak self] (id) in
            self?.listStores(by: id)
        }).disposed(by: disposeBag)
    }
    
    private func listStores(by cousineId: Int) {
        self.loading.value = true
        APIClient.listStore(by: cousineId).subscribe({ [weak self] (event) in
            switch event {
            case .next(let stores):
                self?.stores.value = stores
            case .error(let error):
                self?.error.value = error
            case .completed:
                self?.loading.value = false
                break
            }
        }).disposed(by: disposeBag)
    }
    
    func setCousineId(id: Int) {
        self.cousineId.value = id
    }
    
    func refreshStores() {
        self.listStores(by: self.cousineId.value)
    }
    
}
