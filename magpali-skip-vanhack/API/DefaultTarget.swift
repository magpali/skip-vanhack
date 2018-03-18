//
//  DefaultTarget.swift
//  magpali-skip-vanhack
//
//  Created by Victor Robertson on 18/03/18.
//  Copyright © 2018 magpali. All rights reserved.
//

import RxSwift
import Moya

enum DefaultTarget {
    case listCousine()
    case listStore(cousineId: Int)
    case listProducts(storeId: Int)
    case login(email: String, password: String)
    case signUp(email: String, name: String, address: String, password: String)
}

extension DefaultTarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://api-vanhack-event-sp.azurewebsites.net/api/v1")!
    }
    
    var path: String {
        switch self {
        case .listCousine:
            return "Cousine"
        case .listStore(let cousineId):
            return "Cousine/\(cousineId)/stores"
        case .listProducts(let storeId):
            return "Store/\(storeId)/products"
        case .login:
            return "Customer/auth"
        case .signUp:
            return "Customer"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listCousine, .listStore, .listProducts:
            return .get
        case .login, .signUp:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestParameters(parameters: self.parameters ?? [:],
                                      encoding: self.parameterEncoding)
    }
    
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = AuthHelper.getToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .login(email, password):
            return ["email": email as Any,
                    "password": password as Any]
        case let .signUp(email, name, address, password):
            return ["email": email as Any,
                    "name": name as Any,
                    "address": address as Any,
                    "password": password as Any]
        case .listCousine, .listStore, .listProducts:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
}
