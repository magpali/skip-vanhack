//
//  ListProductsViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift

class ListProductsViewModel: BaseViewModel {
    
    private let storeId: Variable<Int>
    var products = Variable<[Product]>([])
    
    init(storeId: Int) {
        self.storeId = Variable<Int>(storeId)
        super.init()
        listProducts(by: storeId)
        bind()
    }
    
    func bind() {
        storeId.asObservable().subscribe(onNext: { [unowned self] (id) in
            self.listProducts(by: id)
        }).disposed(by: disposeBag)
    }
    
    private func listProducts(by storeId: Int) {
        self.loading.value = true
        APIClient.listProducts(by: storeId).subscribe({ [unowned self] (event) in
            switch event {
            case .next(let stores):
                self.products.value = stores
            case .error(let error):
                self.error.value = error
            case .completed:
                self.loading.value = false
                break
            }
        }).disposed(by: disposeBag)
    }
    
    func addProductToCart(with index: Int) {
        guard products.value.indices.contains(index) else { return }
        let product = products.value[index]
        CartManager.addProductToCart(product)
    }
    
    func setStoreId(id: Int) {
        self.storeId.value = id
    }
    
    func refreshProducts() {
        self.listProducts(by: self.storeId.value)
    }
    
}
