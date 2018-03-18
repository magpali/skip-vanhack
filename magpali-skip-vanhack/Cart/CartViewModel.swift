//
//  CartViewModel.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit
import RxSwift

class CartViewModel: BaseViewModel {

    let cartList = Variable<[Product]>([])
    
    override init() {
        super.init()
        cartList.value = CartManager.getCartList()
    }
    
    func refreshCart() {
        cartList.value = CartManager.getCartList()
    }
    
    func clearCart() {
        CartManager.clearCart()
        refreshCart()
    }
    
    func placeOrder() {
        //TODO: GROUP ORDERS BY STORE ID BEFORE PLACING ORDER
        //TODO: GET USER INFO 'CONTACT + DELIVERY ADDRESS' BEFORE PLACING ORDER
        self.loading.value = true
        APIClient.placeOrder(cartList.value).subscribe { [unowned self] (event) in
            switch event {
            case .next:
                print("it works")
                break
            case .error(let error):
                self.error.value = error
            case .completed:
                self.loading.value = false
            }
        }.disposed(by: disposeBag)
    }
    
    func userIsAuthenticated() -> Bool {
        guard let _ = AuthHelper.getToken() else { return false }
        return true
    }
    
}
