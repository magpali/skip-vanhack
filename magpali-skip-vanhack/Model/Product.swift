//
//  Product.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import UIKit

class Product: Codable {
    var id: Int?
    var storeId: Int?
    var name: String?
    var detailedInfo: String?
    var price: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case storeId = "storeId"
        case name = "name"
        case detailedInfo = "description"
        case price = "price"
    }
}
