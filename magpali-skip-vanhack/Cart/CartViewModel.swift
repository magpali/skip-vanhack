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
        
    }
    
    func userIsAuthenticated() -> Bool {
        guard let _ = AuthHelper.getToken() else { return false }
        return true
    }
    
}
