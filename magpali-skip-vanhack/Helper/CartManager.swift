//
//  CartManager.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

fileprivate let cartKey = "cartList"

class CartManager: NSObject {
    
    static func addProductToCart(_ product: Product) {
        var cartArray: [Product] = CartManager.getCartList()
        cartArray.append(product)
        let encoder = JSONEncoder()
        guard let cartData = try? encoder.encode(cartArray) else { return }
        UserDefaults.standard.set(cartData, forKey: cartKey)
    }
    
    static func getCartList() -> [Product] {
        let decoder = JSONDecoder()
        guard let cartData = UserDefaults.standard.data(forKey: cartKey),
            let cartArray = try? decoder.decode([Product].self, from: cartData) else { return [] }
        return cartArray
    }
    
    static func clearCart() {
        UserDefaults.standard.removeObject(forKey: cartKey)
    }

}
